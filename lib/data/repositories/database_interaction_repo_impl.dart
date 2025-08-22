import 'package:synapse/core/domain/repositories/database_interaction_repo.dart';
import 'package:synapse/data/datasources/local/database/daos/local_database_dao.dart';
import 'package:synapse/data/datasources/local/database/database.dart';

class DataBaseInteractionRepositoryImpl implements DataBaseInteractionRepository {

  final SynapseLocalDao _synapseLocalDao;
  DataBaseInteractionRepositoryImpl(this._synapseLocalDao);


  @override
  Future<int> addUserContent(UserSharedTableCompanion entry) {
   return _synapseLocalDao.insertUserContent(entry);
  }

  @override
  Future<List<UserSharedTableData>> fetchUserContent({int limit = 15, int? lastCreatedAt}) {
   return _synapseLocalDao.getUserContent(limit: limit,lastCreatedAt: lastCreatedAt);
  }

  @override
  Future<UserSharedTableData?> getUserContentById(int id) {
    return _synapseLocalDao.getUserContentById(id);
  }

}