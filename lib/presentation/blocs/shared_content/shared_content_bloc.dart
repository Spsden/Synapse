import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapse/core/domain/usecases/process_shard_content_usecase.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_event.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_state.dart';
import 'package:synapse/services/platform/audio_record_service.dart';

class SharedContentBloc extends Bloc<SharedContentEvent, SharedContentState> {
  final ProcessSharedContentUseCase _processSharedContentUseCase;
  final AudioRecordingService _audioRecordingService;
  StreamSubscription? _sharedContentSubscription;

  SharedContentBloc(
    this._processSharedContentUseCase,
    this._audioRecordingService,
  ) : super(SharedContentInitial()) {
    on<SharedContentInitialize>(_onInitialize);
    on<SharedContentReceived>(_onContentReceived);
    on<AddAdditionalMessage>(_onAddAdditionalMessage);
    on<StartAudioRecording>(_onStartAudioRecording);
    on<StopAudioRecording>(_onStopAudioRecording);
    on<AudioRecordingCompleted>(_onAudioRecordingCompleted);
    on<AudioRecordingFailed>(_onAudioRecordingFailed);
    on<SelectLlmType>(_onSelectLlmType);
  }

  Future<void> _onInitialize(
    SharedContentInitialize event,
    Emitter<SharedContentState> emit,
  ) async {
    try {
      emit(SharedContentInitializing());
      if (kDebugMode) {
        print("SharedContentBloc initializing...");
      }
      _sharedContentSubscription = _processSharedContentUseCase
          .sharedContentStream
          .listen((content) {
            if (kDebugMode) {
              print("Shared content received in bloc: $content");
            }
            add(SharedContentReceived(content));
          });

      //to setup databases or stuff, currently useless
      await _processSharedContentUseCase.initialize();

      emit(SharedContentReady());
    } catch (e) {
      emit(SharedContentError("Failed to initialize : $e"));
    }
  }

  Future<void> _onContentReceived(
    SharedContentReceived event,
    Emitter<SharedContentState> emit,
  ) async {
    emit(SharedContentDisplaying(content: event.content));
  }

  Future<void> _onAddAdditionalMessage(AddAdditionalMessage event,Emitter<SharedContentState> emit) async {
    if(state is SharedContentDisplaying) {
      final currentState = state as SharedContentDisplaying;
      emit(currentState.copyWith(additionalText: event.message));
    }

  }

  Future<void> _onStartAudioRecording(StartAudioRecording event, Emitter<SharedContentState> emit) async {
    if(state is SharedContentDisplaying) {
      final currentState = state as SharedContentDisplaying;

      try {
        emit(currentState.copyWith(audioRecordingStatus: AudioRecordingStatus.recording));

        // _recordingDurationSubscription = _audioRecordingService
        //     .recordingDurationStream
        //     .listen((duration) {
        //   if (state is SharedContentDisplaying) {
        //     final displayState = state as SharedContentDisplaying;
        //     emit(displayState.copyWith(
        //       recordingDuration: duration,
        //       audioRecordingStatus: AudioRecordingStatus.recording,
        //     ));
        //   }
        // });

        await _audioRecordingService.startRecording();

      } catch (e) {
        add(AudioRecordingFailed(e.toString()));
      }
    }
  }

  Future<void> _onStopAudioRecording(StopAudioRecording event, Emitter<SharedContentState> emit) async {
    if (state is SharedContentDisplaying) {
      final currentState = state is SharedContentDisplaying;

      try {
        final audioPath = await _audioRecordingService.stopRecording();
        if(audioPath!=null){
          add(AudioRecordingCompleted(audioPath));
        }else {
          add(AudioRecordingFailed('Failed to save recording'));
        }
      } catch (e) {
        add(AudioRecordingFailed(e.toString()));
      }
    }
  }

  void _onAudioRecordingCompleted(
      AudioRecordingCompleted event,
      Emitter<SharedContentState> emit,
      ) {
    if (state is SharedContentDisplaying) {
      final currentState = state as SharedContentDisplaying;
      emit(currentState.copyWith(
        audioClipPath: event.audioPath,
        audioRecordingStatus: AudioRecordingStatus.stopped,
      ));
    }
  }

  void _onAudioRecordingFailed(
      AudioRecordingFailed event,
      Emitter<SharedContentState> emit,
      ) {
    if (state is SharedContentDisplaying) {
      final currentState = state as SharedContentDisplaying;
      emit(currentState.copyWith(audioRecordingStatus: AudioRecordingStatus.idle));
      // Also emit error but maintain the displaying state
      emit(SharedContentError('Audio recording failed: ${event.error}',
          content: currentState.content));
      // Return to displaying state
      emit(currentState.copyWith(audioRecordingStatus: AudioRecordingStatus.idle));
    }
  }

  void _onRemoveAudioClip(
      RemoveAudioClip event,
      Emitter<SharedContentState> emit,
      ) {
    if (state is SharedContentDisplaying) {
      final currentState = state as SharedContentDisplaying;

      // Delete the audio file if it exists
      if (currentState.audioClipPath != null) {
        _audioRecordingService.deleteRecording(currentState.audioClipPath!);
      }

      emit(currentState.copyWith(
        audioClipPath: null,
        audioRecordingStatus: AudioRecordingStatus.idle,
        recordingDuration: null,
      ));
    }
  }

  void _onSelectLlmType(
      SelectLlmType event,
      Emitter<SharedContentState> emit,
      ) {
    if (state is SharedContentDisplaying) {
      final currentState = state as SharedContentDisplaying;
      emit(currentState.copyWith(selectedLlmType: event.llmType));
    }
  }


  @override
  Future<void> close() {
    _sharedContentSubscription?.cancel();
    // _recordingDurationSubscription?.cancel();
    return super.close();
  }


}
