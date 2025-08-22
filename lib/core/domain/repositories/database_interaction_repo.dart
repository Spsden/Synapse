import 'package:synapse/data/data_sources/local/database/database.dart';

abstract class DataBaseInteractionRepository {

  Future<int> addUserContent(UserSharedTableCompanion entry);
  Future<UserSharedTableData?> getUserContentById(int id);
  Future<List<UserSharedTableData>> fetchUserContent({int limit, int? lastCreatedAt});

}