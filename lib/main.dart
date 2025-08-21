import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:synapse/core/domain/repositories/implementations/shared_content_repo_impl.dart';
import 'package:synapse/core/domain/usecases/process_shard_content_usecase.dart';
import 'package:synapse/core/theme/theme.dart';
import 'package:synapse/presentation/blocs/app_router/app_router_bloc.dart';
import 'package:synapse/presentation/blocs/shared_content/shared_content_bloc.dart';
import 'package:synapse/presentation/screens/home/home_screen.dart';
import 'package:synapse/presentation/screens/shared_content/shared_content_screen.dart';
import 'package:synapse/services/platform/audio_record_service.dart';
import 'package:synapse/services/platform/share_handler_service.dart';

void main() {
  runApp(SynapseApp());
}

class SynapseApp extends StatelessWidget {
  SynapseApp({super.key});

  final ShareHandlerService _shareHandlerService = ShareHandlerService();

  late final GoRouter _router = GoRouter(
    initialLocation: '/shared_content',
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
      if (_shareHandlerService.hasInitialSharedContent && state.path == '/') {
        return '/shared-content';
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
          create: (context) => AppRouterBloc(_shareHandlerService, _router),
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
