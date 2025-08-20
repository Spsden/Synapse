import 'package:synapse/core/domain/entities/shared_content.dart';

abstract class SharedContentRepository {
  Stream<SharedContent> get sharedContentStream;
  Future<void> initialize();
  // Future<void> recordSentMessage(
  //
  // {
}