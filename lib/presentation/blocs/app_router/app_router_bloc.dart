import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:synapse/presentation/blocs/app_router/app_router_event.dart';
import 'package:synapse/presentation/blocs/app_router/app_router_state.dart';
import 'package:synapse/services/platform/share_handler_service.dart';

class AppRouterBloc extends Bloc<AppRouterEvent, AppRouterState> {
  final ShareHandlerService _shareHandlerService;
  final GoRouter _router;
  StreamSubscription? _sharedContentSubscription;

  bool _launchedViaShare = false;
  bool get launchedViaShare => _launchedViaShare;

  AppRouterBloc(this._shareHandlerService, this._router)
    : super(AppRouterInitializing()) {
    if (kDebugMode) {
      print("✅ AppRouterBloc has been created." );
    }

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

      if (kDebugMode) {
        print("AppRouterBloc is initializing and starting listeners...");
      }

      await _shareHandlerService.initialize();

      if (kDebugMode) {
        print("Has initial shared content: ${_shareHandlerService.hasInitialSharedContent}");
      }

      if (_shareHandlerService.hasInitialSharedContent) {
        // App was launched via share intent
        _launchedViaShare = true; // Set the flag
        if (kDebugMode) {
          print(" App launched with shared content - going to SharedContentScreen");
        }
        emit(AppRouterSharedContent());
      } else {
        // Normal app launch
        print(" Normal app launch - going to HomeScreen");
        emit(AppRouterHome());
      }

      // This handles shares that happen WHILE the app is running
      _listenToSharedContent();

    } catch (e) {
      if(kDebugMode){
        print("Error from app router bloc : $e");
      }
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
    _launchedViaShare = false;
    _router.goNamed('shared_content');
    emit(AppRouterSharedContent());
  }

  // for handling the content shared if app is running in background
  void _listenToSharedContent() {
    _sharedContentSubscription?.cancel();
    _sharedContentSubscription = _shareHandlerService.sharedContentStream
        .listen((sharedContent) {
          if (kDebugMode) {
            print("New shared content while app running: $sharedContent");
          }
          add(SharedContentDetected());
        });
  }

  void resetLaunchFlag() {
    _launchedViaShare = false;
  }

  @override
  Future<void> close() {
    _sharedContentSubscription?.cancel();
    return super.close();
  }
}

