import 'package:equatable/equatable.dart';
import 'package:synapse/core/domain/entities/shared_attachment.dart';

class SharedContent extends Equatable {
  final String? conversationIdentifier;
  final String? content;
  final List<SharedAttachment> attachments;
  final DateTime receivedAt;

  const SharedContent({
    this.conversationIdentifier,
    this.content,
    required this.attachments,
    required this.receivedAt,
  });

  bool get hasImages =>
      attachments.any((a) => a.type == SharedAttachmentType.image);

  bool get hasText => content?.isNotEmpty == true;

  @override
  List<Object?> get props => [
    conversationIdentifier,
    content,
    attachments,
    receivedAt,
  ];

}
