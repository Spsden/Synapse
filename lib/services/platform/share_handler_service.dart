import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_handler/share_handler.dart';
import 'package:synapse/data/models/shared_content_model.dart';

class ShareHandlerService {
  static final ShareHandlerService _instance = ShareHandlerService._internal();
  factory ShareHandlerService() => _instance;

  ShareHandlerService._internal();

  late final BehaviorSubject<SharedContentModel> _sharedContentController =
      BehaviorSubject<SharedContentModel>();

  final ShareHandlerPlatform _handler = ShareHandlerPlatform.instance;
  SharedContentModel? _initialSharedContent;

  Stream<SharedContentModel> get sharedContentStream =>
      _sharedContentController.stream;

  bool get hasInitialSharedContent => _initialSharedContent != null;
  bool _initialized = false;

  Future<void> initialize() async {

    if(kDebugMode) {
      print("🟢 WHO CALLED initialize method in the share service?");
      print(StackTrace.current.toString().split('\n').take(5).join('\n'));
    }
    if (_initialized) {
      if(kDebugMode){
        print("⚠️ ShareHandlerService already initialized, skipping...");
      }
      return;
    }


    // Check if app was launched via share intent
    final initialMedia = await _handler.getInitialSharedMedia();
    if (kDebugMode) {
      print("Initial media from plugin: $initialMedia");
    }

    if (initialMedia != null) {
      _setSharedContent(initialMedia);
    }

    // Listen for runtime shared content
    _handler.sharedMediaStream.listen((SharedMedia media) {
      _setSharedContent(media);
    });

    _initialized = true;
    if (kDebugMode) {
      print("✅ ShareHandlerService initialization complete");
    }

  }

  void _setSharedContent(SharedMedia media) {
    if(kDebugMode) {
      print("🟢 WHO CALLED setSharedContent method in the share service?");
      print(StackTrace.current.toString().split('\n').take(5).join('\n'));
    }
    final sharedContent = SharedContentModel.fromSharedMedia(media);


    if (kDebugMode) {
      print("📤 [ShareHandlerService] Adding content: $sharedContent");
    }
    try {
      _sharedContentController.add(sharedContent);

      // ✅ Only update this if the add is successful

      _initialSharedContent = sharedContent;
    } catch (e, stack) {
      if (kDebugMode) {
        print("[ShareHandlerService] Failed to add shared content: $e");
        print(stack);
      }
    }
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
