import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synapse/data/data_sources/local/database/daos/local_database_dao.dart';

import 'entities/content_analyses.dart';
import 'entities/user_shared_table.dart';
part 'database.g.dart';

@DriftDatabase(tables: [UserSharedTable,ContentAnalyses],daos: [SynapseLocalDao])
class SynapseAppDataBase extends _$SynapseAppDataBase {

  SynapseAppDataBase._internal() : super(_openConnection());

  static final SynapseAppDataBase _instance = SynapseAppDataBase._internal();
  factory SynapseAppDataBase() => _instance;



  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
