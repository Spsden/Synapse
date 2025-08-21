import 'package:equatable/equatable.dart';

abstract class AppRouterEvent extends Equatable {
  const AppRouterEvent();

  @override
  List<Object?> get props => [];
}

class AppRouterInitialize extends AppRouterEvent {}

class NavigateToHome extends AppRouterEvent {}

class NavigateToSharedContent extends AppRouterEvent {}

class SharedContentDetected extends AppRouterEvent {}