import 'package:flutter/foundation.dart';
import 'package:synapse/core/domain/entities/shared_content.dart';
import 'package:synapse/core/domain/repositories/interfaces/shared_content_repo.dart';

import '../entities/shared_attachment.dart';

class ProcessSharedContentUseCase {
  final SharedContentRepository _repository;

  ProcessSharedContentUseCase(this._repository);

  // Stream<SharedContent> get sharedContentStream =>
  //     _repository.sharedContentStream;

  Stream<SharedContent> get sharedContentStream {
    if (kDebugMode) {
      print("🟢 [UseCase] Someone subscribed to shardContentStream");
    }

    return _repository.sharedContentStream;
  }



  Future<void> initialize() async {
    ///TODO initialise something else here
    // await _repository.initialize();
  }

  Future<void> processSharedContent(SharedContent content) async {
    // Process images with LLM
    if (content.hasImages) {
      for (final attachment in content.attachments) {
        if (attachment.type == SharedAttachmentType.image &&
            attachment.path != null) {
          if (kDebugMode) {
            print(attachment.toString());
          }
        }
      }
    }

    // Process text content if available
    if (content.hasText) {
    }
  }
}
