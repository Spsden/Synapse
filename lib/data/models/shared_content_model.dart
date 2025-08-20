import 'package:share_handler/share_handler.dart';
import 'package:synapse/core/domain/entities/shared_content.dart';
import 'package:synapse/core/domain/entities/shared_attachment.dart' as synapse_attachment;

class SharedContentModel extends SharedContent {
  const SharedContentModel({
    super.conversationIdentifier,
    super.content,
    required super.attachments,
    required super.receivedAt,
  });

  factory SharedContentModel.fromSharedMedia(SharedMedia media) {
    return SharedContentModel(
      conversationIdentifier: media.conversationIdentifier,
      content: media.content,
      attachments: media.attachments?.map(_mapAttachment).toList() ?? [],
      receivedAt: DateTime.now()
    );
  }

  static synapse_attachment.SharedAttachment _mapAttachment(SharedAttachment? attachment) {
    if(attachment == null){
      return const synapse_attachment.SharedAttachment(type: synapse_attachment.SharedAttachmentType.unknown);
    }

    synapse_attachment.SharedAttachmentType type;
    switch (attachment.type) {
      case SharedAttachmentType.image:
        type = synapse_attachment.SharedAttachmentType.image;
        break;
      case SharedAttachmentType.video:
        type = synapse_attachment.SharedAttachmentType.video;
        break;
      case SharedAttachmentType.file:
        type = synapse_attachment.SharedAttachmentType.file;
        break;
      default:
        type = synapse_attachment.SharedAttachmentType.unknown;
    }

    return synapse_attachment.SharedAttachment(
      path: attachment.path,
      type: type,
    );
  }
}
