import 'package:equatable/equatable.dart';

import '../../../data/data_sources/local/database/database.dart';

abstract class ContentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContentInitial extends ContentState {}

class ContentLoading extends ContentState {}

class UserContentLoaded extends ContentState {
  final List<UserSharedTableData> contents;
  final bool hasMore;

  UserContentLoaded(this.contents, {this.hasMore = true});

  @override
  List<Object?> get props => [contents, hasMore];
}

class ContentAnalysesLoaded extends ContentState {
  final List<ContentAnalyse> analyses;
  final bool hasMore;

  ContentAnalysesLoaded(this.analyses, {this.hasMore = true});

  @override
  List<Object?> get props => [analyses, hasMore];
}

class CombinedContentLoaded extends ContentState {
  final List<Map<String, dynamic>> data;
  final bool hasMore;

  CombinedContentLoaded(this.data, {this.hasMore = true});

  @override
  List<Object?> get props => [data, hasMore];
}

class SingleContentLoaded extends ContentState {
  final dynamic item; // Can be UserSharedTableData OR ContentAnalysesData
  SingleContentLoaded(this.item);

  @override
  List<Object?> get props => [item];
}

class ContentInserted extends ContentState {
  final int insertedId; // Can be UserSharedTableData OR ContentAnalysesData
  ContentInserted(this.insertedId);

  @override
  List<Object?> get props => [insertedId];
}

class LocalDataBaseContentError extends ContentState {
  final String message;

  LocalDataBaseContentError(this.message);

  @override
  List<Object?> get props => [message];
}
