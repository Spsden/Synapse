import 'package:equatable/equatable.dart';

import '../../../core/domain/entities/shared_content.dart';

enum LlmProcessingType { local, cloud }
enum AudioRecordingStatus { idle, recording, stopped, processing }


abstract class SharedContentEvent extends Equatable {
  const SharedContentEvent();
  @override
  List<Object?> get props => [];
}

class SharedContentInitialize extends SharedContentEvent {}


class SharedContentReceived extends SharedContentEvent {
  final SharedContent content;

  const SharedContentReceived(this.content);

  @override
  List<Object> get props => [content];
}

class AddAdditionalMessage extends SharedContentEvent {
  final String message;
  const AddAdditionalMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class StartAudioRecording extends SharedContentEvent {}

class StopAudioRecording extends SharedContentEvent {}

class AudioRecordingCompleted extends SharedContentEvent {
  final String audioPath;

  const AudioRecordingCompleted(this.audioPath);

  @override
  List<Object> get props => [audioPath];
}

class AudioRecordingFailed extends SharedContentEvent {
  final String error;

  const AudioRecordingFailed(this.error);

  @override
  List<Object> get props => [error];
}

class RemoveAudioClip extends SharedContentEvent {}

class StartProcessing extends SharedContentEvent {
  final SharedContent content;
  final LlmProcessingType llmType;
  final String? additionalText;
  final String? audioClipPath;

  const StartProcessing({
    required this.content,
    required this.llmType,
    this.additionalText,
    this.audioClipPath,
  });

  @override
  List<Object?> get props => [content, llmType, additionalText, audioClipPath];
}

class ProcessSharedContent extends SharedContentEvent {
  final SharedContent content;
  final LlmProcessingType llmType;
  final String? additionalText;
  final String? audioClipPath;

  const ProcessSharedContent({
    required this.content,
    required this.llmType,
    this.additionalText,
    this.audioClipPath,
  });

  @override
  List<Object?> get props => [content, llmType, additionalText, audioClipPath];
}

class SelectLlmType extends SharedContentEvent {
  final LlmProcessingType llmType;

  const SelectLlmType(this.llmType);

  @override
  List<Object> get props => [llmType];
}




// class RecordSentMessage extends SharedContentEvent {
//   final String conversationIdentifier;
//   final String conversationName;
//   final String? conversationImageFilePath;
//   final String serviceName;
//
//   const RecordSentMessage({
//     required this.conversationIdentifier,
//     required this.conversationName,
//     this.conversationImageFilePath,
//     required this.serviceName,
//   });
//
//   @override
//   List<Object?> get props => [
//     conversationIdentifier,
//     conversationName,
//     conversationImageFilePath,
//     serviceName,
//   ];
// }


