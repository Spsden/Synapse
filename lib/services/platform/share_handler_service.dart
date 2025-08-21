import 'dart:async';

import 'package:share_handler/share_handler.dart';
import 'package:synapse/data/models/shared_content_model.dart';

class ShareHandlerService {
  static final ShareHandlerService _instance = ShareHandlerService._internal();

  factory ShareHandlerService() => _instance;

  // private constructor in dart
  ShareHandlerService._internal();

  late final StreamController<SharedContentModel> _sharedContentController =
  StreamController<SharedContentModel>.broadcast();


  final ShareHandlerPlatform _handler = ShareHandlerPlatform.instance;
  SharedContentModel? _initialSharedContent;

  Stream<SharedContentModel> get sharedContentStream =>
      _sharedContentController.stream;


  // Stream<SharedContentModel> get sharedContentStream {
  //   // ignore: prefer_conditional_assignment
  //   if (_sharedContentController == null) {
  //     _sharedContentController =
  //         StreamController<SharedContentModel>.broadcast();
  //   }
  //   return _sharedContentController!.stream;
  // }

  bool get hasInitialSharedContent => _initialSharedContent != null;

  Future<void> initialize() async {
    // _sharedContentController ??=
    //     StreamController<SharedContentModel>.broadcast();

    final initialMedia = await _handler.getInitialSharedMedia();
    if (initialMedia != null) {
      _initialSharedContent = SharedContentModel.fromSharedMedia(initialMedia);
      _emitSharedContent(initialMedia);
    }

    _handler.sharedMediaStream.listen((SharedMedia media) {
      _emitSharedContent(media);
    });
  }

  void _emitSharedContent(SharedMedia media) {
    final sharedContent = SharedContentModel.fromSharedMedia(media);
    print("📤 [ShareHandlerService] Adding content: $sharedContent");
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
  }
}
