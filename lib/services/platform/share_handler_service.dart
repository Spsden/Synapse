import 'dart:async';
import 'package:share_handler/share_handler.dart';
import 'package:synapse/data/models/shared_content_model.dart';

class ShareHandlerService {
  static final ShareHandlerService _instance = ShareHandlerService._internal();
  factory ShareHandlerService() => _instance;

  ShareHandlerService._internal();

  late final StreamController<SharedContentModel> _sharedContentController =
  StreamController<SharedContentModel>.broadcast();

  final ShareHandlerPlatform _handler = ShareHandlerPlatform.instance;
  SharedContentModel? _initialSharedContent;

  Stream<SharedContentModel> get sharedContentStream =>
      _sharedContentController.stream;

  bool get hasInitialSharedContent => _initialSharedContent != null;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) {
      print("⚠️ ShareHandlerService already initialized, skipping...");
      return;
    }

    // Check if app was launched via share intent
    final initialMedia = await _handler.getInitialSharedMedia();
    print("Initial media from plugin: $initialMedia");

    if (initialMedia != null) {
      _setSharedContent(initialMedia);
    }

    // Listen for runtime shared content
    _handler.sharedMediaStream.listen((SharedMedia media) {
      _setSharedContent(media);
    });

    _initialized = true;
  }

  void _setSharedContent(SharedMedia media) {
    final sharedContent = SharedContentModel.fromSharedMedia(media);

    // ✅ Update the cached initial content (so getter returns true)
    _initialSharedContent = sharedContent;

    print("📤 [ShareHandlerService] Adding content: $sharedContent");
    _sharedContentController.add(sharedContent);
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
    _initialized = false;
    _sharedContentController.close();
  }
}
