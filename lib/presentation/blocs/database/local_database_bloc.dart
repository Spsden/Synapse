// lib/presentation/bloc/content_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapse/core/domain/repositories/database_interaction_repo.dart';

import 'local_database_event.dart';
import 'local_database_state.dart';


class LocalDataBaseContentBloc extends Bloc<ContentEvent, ContentState> {
  final DataBaseInteractionRepository _dataBaseInteractionRepository;

  LocalDataBaseContentBloc(this._dataBaseInteractionRepository) : super(ContentInitial()) {
    on<FetchUserContent>(_onFetchUserContent);
    on<FetchContentAnalyses>(_onFetchAnalyses);
    on<InsertUserContent>(_onContentInserted);
    // on<SearchAnalyses>(_onSearchAnalyses);
    // on<FetchCombinedContent>(_onFetchCombinedContent);
  }

  Future<void> _onFetchUserContent(
      FetchUserContent event, Emitter<ContentState> emit) async {
    emit(ContentLoading());
    try {
      final results = await _dataBaseInteractionRepository.fetchUserContent(
        limit: event.limit,
        lastCreatedAt: event.lastCreatedAt,
      );
      emit(UserContentLoaded(results, hasMore: results.length == event.limit));
    } catch (e) {
      emit(LocalDataBaseContentError(e.toString()));
    }
  }

  Future<void> _onContentInserted(InsertUserContent event, Emitter<ContentState> emit) async{
    try {
      final int result = await _dataBaseInteractionRepository.addUserContent(event.content);
      emit(ContentInserted(result));
    } catch (e) {
      emit(LocalDataBaseContentError(e.toString()));
    }

}

  Future<void> _onFetchAnalyses(
      FetchContentAnalyses event, Emitter<ContentState> emit) async {
    emit(ContentLoading());
    // try {
    //   final results = await _dataBaseInteractionRepository.(
    //     contentId: event.contentId,
    //     limit: event.limit,
    //     lastCreatedAt: event.lastCreatedAt,
    //   );
    //   emit(ContentAnalysesLoaded(results, hasMore: results.length == event.limit));
    // } catch (e) {
    //   emit(ContentError(e.toString()));
    // }
  }

  // Future<void> _onSearchAnalyses(
  //     SearchAnalyses event, Emitter<ContentState> emit) async {
  //   emit(ContentLoading());
  //   try {
  //     final results =
  //         await _dataBaseInteractionRepository.searchAnalysesByMetadata(event.keyword);
  //     emit(AnalysesLoaded(results, hasMore: false));
  //   } catch (e) {
  //     emit(ContentError(e.toString()));
  //   }
  // }

  // Future<void> _onFetchCombinedContent(
  //     FetchCombinedContent event, Emitter<ContentState> emit) async {
  //   emit(ContentLoading());
  //   try {
  //     final results =
  //         await _dataBaseInteractionRepository.fetchUserContentWithAnalyses(
  //       limit: event.limit,
  //       lastCreatedAt: event.lastCreatedAt,
  //     );
  //     emit(CombinedContentLoaded(results, hasMore: results.length == event.limit));
  //   } catch (e) {
  //     emit(ContentError(e.toString()));
  //   }
  // }
}
