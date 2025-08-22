import 'package:equatable/equatable.dart';

import '../../../data/data_sources/local/database/database.dart';

abstract class ContentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class FetchUserContentById extends ContentEvent {
  final int id;
  final bool isAnalysis;

  FetchUserContentById({required this.id, this.isAnalysis = false});

  @override
  List<Object?> get props => [id, isAnalysis];
}

class InsertUserContent extends ContentEvent {
  final UserSharedTableCompanion content;

  InsertUserContent(this.content);

  @override
  List<Object?> get props => [content];
}

class InsertContentAnalysis extends ContentEvent {
  final ContentAnalysesCompanion analysis;

  InsertContentAnalysis(this.analysis);

  @override
  List<Object?> get props => [analysis];
}

class FetchUserContent extends ContentEvent {
  final int limit;
  final int? lastCreatedAt;

  FetchUserContent({this.limit = 20, this.lastCreatedAt});

  @override
  List<Object?> get props => [limit, lastCreatedAt];
}

class FetchContentAnalyses extends ContentEvent {
  final int contentId;
  final int limit;
  final int? lastCreatedAt;

  FetchContentAnalyses({
    required this.contentId,
    this.limit = 20,
    this.lastCreatedAt,
  });

  @override
  List<Object?> get props => [contentId, limit, lastCreatedAt];
}

class SearchContentAnalyses extends ContentEvent {
  final String keyword;

  SearchContentAnalyses(this.keyword);

  @override
  List<Object?> get props => [keyword];
}

class FetchCombinedContent extends ContentEvent {
  final int limit;
  final int? lastCreatedAt;

  FetchCombinedContent({this.limit = 20, this.lastCreatedAt});

  @override
  List<Object?> get props => [limit, lastCreatedAt];
}
