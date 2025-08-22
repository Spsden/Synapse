import 'package:drift/drift.dart';
import 'package:synapse/data/data_sources/local/database/entities/user_shared_table.dart';
import 'package:synapse/data/data_sources/local/database/entities/content_analyses.dart';

import '../database.dart';

part 'local_database_dao.g.dart';

@DriftAccessor(tables: [UserSharedTable, ContentAnalyses])
class SynapseLocalDao extends DatabaseAccessor<SynapseAppDataBase>
    with _$SynapseLocalDaoMixin {
  SynapseLocalDao(super.db);

  // USER SHARED TABLE METHODS

  Future<int> insertUserContent(UserSharedTableCompanion entry) =>
      into(db.userSharedTable).insert(entry);

  Future<List<UserSharedTableData>> getUserContent({
    int limit = 20,
    int? lastCreatedAt,
  }) {
    final query = select(db.userSharedTable)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);

    // Fetch records created before the last fetched one
    if (lastCreatedAt != null) {
      query.where((t) => t.createdAt.isSmallerThanValue(lastCreatedAt));
    }

    return query.get();
  }

  Future<UserSharedTableData?> getUserContentById(int id) {
    return (select(
      db.userSharedTable,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> deleteUserContent(int id) {
    return (delete(db.userSharedTable)..where((t) => t.id.equals(id))).go();
  }

  // CONTENT ANALYSES METHODS

  Future<int> insertAnalysis(ContentAnalysesCompanion analysis) =>
      into(db.contentAnalyses).insert(analysis);

  /// Keyset paginated fetch for analyses by contentId
  Future<List<ContentAnalyse>> getAnalysesByContent(
    int contentId, {
    int limit = 20,
    int? lastCreatedAt,
  }) {
    final query = select(db.contentAnalyses)
      ..where((t) => t.contentId.equals(contentId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);

    if (lastCreatedAt != null) {
      query.where((t) => t.createdAt.isSmallerThanValue(lastCreatedAt));
    }

    return query.get();
  }

  Future<ContentAnalyse?> getAnalysisById(int id) {
    return (select(
      db.contentAnalyses,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> deleteAnalysis(int id) {
    return (delete(db.contentAnalyses)..where((t) => t.id.equals(id))).go();
  }

  // SEARCH & FILTER METHODS

  Future<List<ContentAnalyse>> searchAnalysesByMetadata(
    String keyword, {
    int limit = 20,
    int? lastCreatedAt,
  }) {
    final query = select(db.contentAnalyses)
      ..where((t) => t.metadata.like('%$keyword%'))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);

    if (lastCreatedAt != null) {
      query.where((t) => t.createdAt.isSmallerThanValue(lastCreatedAt));
    }

    return query.get();
  }

  Future<List<UserSharedTableData>> searchUserContent(
    String keyword, {
    int limit = 20,
    int? lastCreatedAt,
  }) {
    final query = select(db.userSharedTable)
      ..where(
        (t) => t.title.like('%$keyword%') | t.userMessage.like('%$keyword%'),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);

    if (lastCreatedAt != null) {
      query.where((t) => t.createdAt.isSmallerThanValue(lastCreatedAt));
    }

    return query.get();
  }

  // JOINED QUERIES

  /// Get paginated user content + analyses using keyset pagination
  Future<List<Map<String, dynamic>>> getUserContentWithAnalyses({
    int limit = 20,
    int? lastCreatedAt,
  }) async {
    final query =
        select(db.userSharedTable).join([
            leftOuterJoin(
              db.contentAnalyses,
              db.contentAnalyses.contentId.equalsExp(db.userSharedTable.id),
            ),
          ])
          ..orderBy([OrderingTerm.desc(db.userSharedTable.createdAt)])
          ..limit(limit);

    if (lastCreatedAt != null) {
      query.where(
        db.userSharedTable.createdAt.isSmallerThanValue(lastCreatedAt),
      );
    }

    final rows = await query.get();

    return rows.map((row) {
      return {
        'userContent': row.readTable(db.userSharedTable),
        'analysis': row.readTableOrNull(db.contentAnalyses),
      };
    }).toList();
  }

  Future<Map<String, dynamic>?> getSingleContentWithAnalyses(int id) async {
    final query = select(db.userSharedTable).join([
      leftOuterJoin(
        db.contentAnalyses,
        db.contentAnalyses.contentId.equalsExp(db.userSharedTable.id),
      ),
    ])..where(db.userSharedTable.id.equals(id));

    final rows = await query.get();
    if (rows.isEmpty) return null;

    final content = rows.first.readTable(db.userSharedTable);
    final analyses = rows
        .map((row) => row.readTableOrNull(db.contentAnalyses))
        .where((a) => a != null)
        .toList();

    return {'userContent': content, 'analyses': analyses};
  }
}
