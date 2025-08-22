import 'package:synapse/core/domain/entities/shared_content.dart';
import 'package:synapse/core/domain/repositories/shared_content_repo.dart';
import 'package:synapse/services/platform/share_handler_service.dart';

class SharedContentRepositoryImpl implements SharedContentRepository {
  final ShareHandlerService _shareHandlerService;

  SharedContentRepositoryImpl(this._shareHandlerService);

  @override
  Future<void> initialize() async {
    await _shareHandlerService.initialize();
  }

  @override
  Stream<SharedContent> get sharedContentStream =>
      _shareHandlerService.sharedContentStream;
}
