import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:synapse/data/repositories/shared_content_repo_impl.dart';
import 'package:synapse/core/domain/usecases/process_shard_content_usecase.dart';
import 'package:synapse/core/theme/theme.dart';
import 'package:synapse/presentation/blocs/app_router/app_router_bloc.dart';
import 'package:synapse/presentation/blocs/app_router/app_router_event.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_bloc.dart';
import 'package:synapse/presentation/screens/home/home_screen.dart';
import 'package:synapse/presentation/screens/shared_content/shared_content_screen.dart';
import 'package:synapse/services/platform/audio_record_service.dart';
import 'package:synapse/services/platform/share_handler_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ShareHandlerService before creating route
  if(kDebugMode){
    print("MAIN CALLED AGAINNNNNNN");
  }
  final shareHandlerService = ShareHandlerService();
  await shareHandlerService.initialize();

  runApp(SynapseApp(shareHandlerService: shareHandlerService));
}

class SynapseApp extends StatelessWidget {
  final ShareHandlerService _shareHandlerService;

  SynapseApp({super.key, required ShareHandlerService shareHandlerService})
    : _shareHandlerService = shareHandlerService;

  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/shared_content',
        name: 'shared_content',
        builder: (context, state) => SharedContentScreen(),
      ),
    ],
    redirect: (context, state) {
      // Now this will work correctly since ShareHandlerService is already initialized
      if (_shareHandlerService.hasInitialSharedContent &&
          state.uri.path == '/') {
        return '/shared_content';
      }
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    _router.routerDelegate.addListener(() {
      final config = _router.routerDelegate.currentConfiguration;
      debugPrint("🔹 Current Route: ${config.uri.toString()}");
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              AppRouterBloc(_shareHandlerService, _router)
                ..add(AppRouterInitialize()),
        ),
        BlocProvider(
          create: (context) => SharedContentBloc(
            ProcessSharedContentUseCase(
              SharedContentRepositoryImpl(_shareHandlerService),
            ),
            AudioRecordingService(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Synapse',
        theme: AppTheme.theme,
        routerConfig: _router,
      ),
    );
  }
}
