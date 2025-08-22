import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:synapse/presentation/blocs/app_router/app_router_event.dart';
import 'package:synapse/presentation/blocs/app_router/app_router_state.dart';
import 'package:synapse/services/platform/share_handler_service.dart';

class AppRouterBloc extends Bloc<AppRouterEvent, AppRouterState> {
  final ShareHandlerService _shareHandlerService;
  final GoRouter _router;
  StreamSubscription? _sharedContentSubscription;

  AppRouterBloc(this._shareHandlerService, this._router)
    : super(AppRouterInitializing()) {
    print("✅ AppRouterBloc has been created." ); // <-- ADD THIS LINE

    on<AppRouterInitialize>(_onInitialize);
    on<NavigateToHome>(_onNavigateToHome);
    on<NavigateToSharedContent>(_onNavigateToSharedContent);
    on<SharedContentDetected>(_onSharedContentDetected);
  }

  Future<void> _onInitialize(
    AppRouterInitialize event,
    Emitter<AppRouterState> emit,
  ) async {
    try {

      print("▶️ AppRouterBloc is initializing and starting listeners...");

      await _shareHandlerService.initialize();

      print(_shareHandlerService.hasInitialSharedContent.toString() + "SURAJ YE DEKJH");

      if(_router.routerDelegate.currentConfiguration.uri.path == "/" && _shareHandlerService.hasInitialSharedContent == false){
        add(NavigateToHome());
        emit(AppRouterHome());

      } else if(_shareHandlerService.hasInitialSharedContent){
        add(NavigateToSharedContent());
        emit(AppRouterSharedContent());
      } else {
        add(NavigateToHome());
        emit(AppRouterHome());
      }

      // Listen for runtime shared content
      _listenToSharedContent();

      // // Emit ready state (routing is handled by go_router redirect)
      // if (_shareHandlerService.hasInitialSharedContent) {
      //   emit(AppRouterSharedContent());
      // } else {
      //   emit(AppRouterHome());
      // }
    } catch (e) {
      emit(AppRouterHome());
    }
  }

  void _onNavigateToHome(NavigateToHome event, Emitter<AppRouterState> emit) {
    _router.goNamed('home');
    emit(AppRouterHome());
  }

  void _onNavigateToSharedContent(
    NavigateToSharedContent event,
    Emitter<AppRouterState> emit,
  ) {
    _router.goNamed('shared_content');
    emit(AppRouterSharedContent());
  }

  void _onSharedContentDetected(
    SharedContentDetected event,
    Emitter<AppRouterState> emit,
  ) {
    _router.goNamed('shared_content');
    emit(AppRouterSharedContent());
  }

  // for handling the content shared if app is running in background
  void _listenToSharedContent() {
    _sharedContentSubscription?.cancel();
    _sharedContentSubscription = _shareHandlerService.sharedContentStream
        .listen((sharedContent) {
          print("Something detected SURRAJJ");
          add(SharedContentDetected());
        });
  }

  @override
  Future<void> close() {
    _sharedContentSubscription?.cancel();
    return super.close();
  }
}
