import 'package:equatable/equatable.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_event.dart';

import '../../../core/domain/entities/shared_content.dart';


abstract class SharedContentState extends Equatable {
  const SharedContentState();

  @override
  List<Object?> get props => [];
}

class SharedContentInitial extends SharedContentState {}

class SharedContentInitializing extends SharedContentState {}

class SharedContentReady extends SharedContentState {}

class SharedContentReceiving extends SharedContentState {
  final SharedContent content;

  const SharedContentReceiving(this.content);

  @override
  List<Object> get props => [content];
}

class SharedContentError extends SharedContentState {
  final String message;
  final SharedContent? content;

  const SharedContentError(this.message, {this.content});

  @override
  List<Object?> get props => [message, content];
}

class SharedContentRecording extends SharedContentState {}

class SharedContentDisplaying extends SharedContentState {
  final SharedContent content;
  final LlmProcessingType selectedLlmType;
  final String? additionalText;
  final String? audioClipPath;
  final AudioRecordingStatus audioRecordingStatus;
  final Duration? recordingDuration;

  const SharedContentDisplaying({
    required this.content,
    this.selectedLlmType = LlmProcessingType.local,
    this.additionalText,
    this.audioClipPath,
    this.audioRecordingStatus = AudioRecordingStatus.idle,
    this.recordingDuration,
  });

  SharedContentDisplaying copyWith({
    SharedContent? content,
    LlmProcessingType? selectedLlmType,
    String? additionalText,
    String? audioClipPath,
    AudioRecordingStatus? audioRecordingStatus,
    Duration? recordingDuration,
  }) {
    return SharedContentDisplaying(
      content: content ?? this.content,
      selectedLlmType: selectedLlmType ?? this.selectedLlmType,
      additionalText: additionalText ?? this.additionalText,
      audioClipPath: audioClipPath ?? this.audioClipPath,
      audioRecordingStatus: audioRecordingStatus ?? this.audioRecordingStatus,
      recordingDuration: recordingDuration ?? this.recordingDuration,
    );
  }

  @override
  List<Object?> get props => [
    content,
    selectedLlmType,
    additionalText,
    audioClipPath,
    audioRecordingStatus,
    recordingDuration,
  ];
}