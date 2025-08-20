import 'dart:async';

import 'package:share_handler/share_handler.dart';
import 'package:synapse/data/models/shared_content_model.dart';

class ShareHandlerService {
  static final ShareHandlerService _instance = ShareHandlerService._internal();

  factory ShareHandlerService() => _instance;

  // private constructor in dart
  ShareHandlerService._internal();

  final ShareHandlerPlatform _handler = ShareHandlerPlatform.instance;
  StreamController<SharedContentModel>? _sharedContentController;

  Stream<SharedContentModel> get sharedContentStream {
    // ignore: prefer_conditional_assignment
    if (_sharedContentController == null) {
      _sharedContentController =
          StreamController<SharedContentModel>.broadcast();
    }
    return _sharedContentController!.stream;
  }

  Future<void> initialize() async {
    final initialMedia = await _handler.getInitialSharedMedia();
    if(initialMedia!= null){
      _emitSharedContent(initialMedia);
    }

    _handler.sharedMediaStream.listen((SharedMedia media){
      _emitSharedContent(media);
    });
  }

  void _emitSharedContent(SharedMedia media){
    final sharedContent = SharedContentModel.fromSharedMedia(media);
    _sharedContentController?.add(sharedContent);
  }

  Future<void> recordSentMessage({
    required String conversationIdentifier,
    required String conversationName,
    String? conversationImageFilePath,
    required String serviceName,
  }) async {
    await _handler.recordSentMessage(
      conversationIdentifier: conversationIdentifier,
      conversationName: conversationName,
      conversationImageFilePath: conversationImageFilePath,
      serviceName: serviceName,
    );
  }

  void dispose() {
    _sharedContentController?.close();
    _sharedContentController = null;
  }
}
