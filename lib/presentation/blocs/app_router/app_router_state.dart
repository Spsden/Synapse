import 'package:equatable/equatable.dart';

abstract class AppRouterState extends Equatable {
  const AppRouterState();

  @override
  List<Object?> get props => [];
}

class AppRouterInitializing extends AppRouterState {}

class AppRouterHome extends AppRouterState {}

class AppRouterSharedContent extends AppRouterState {}
