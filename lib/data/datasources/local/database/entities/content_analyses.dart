import 'package:drift/drift.dart';
import 'package:synapse/data/datasources/local/database/entities/user_shared_table.dart';

class ContentAnalyses extends Table {
  late final id = integer().autoIncrement()();
  late final contentId = integer()
      .references(UserSharedTable, #id, onDelete: KeyAction.cascade)();
  late final llmType = text().withLength(min: 1, max: 50)();
  late final analysisType = text().withLength(min: 1, max: 50)();
  late final prompt = text().nullable()();
  late final result = text().nullable()();
  late final metadata = text().nullable()();
  late final createdAt = integer().clientDefault(
        () => DateTime.now().millisecondsSinceEpoch,
  )();
  late final processingTimeMs = integer().nullable()();
}
