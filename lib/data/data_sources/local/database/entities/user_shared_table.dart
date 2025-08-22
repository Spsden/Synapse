import 'package:drift/drift.dart';

class UserSharedTable extends Table {
  late final id = integer().autoIncrement()();
  late final contentType = text().withLength(min: 1, max: 20)();
  late final title = text().nullable()();
  late final userMessage = text().nullable()();
  late final audioPath = text().nullable()();
  late final imagePath = text().nullable()();
  late final isProcessed = integer().withDefault(const Constant(0))();
  late final createdAt = integer().clientDefault(
        () => DateTime.now().millisecondsSinceEpoch,
  )();
}
