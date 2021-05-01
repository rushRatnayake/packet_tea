part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardInProgressState extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardSuccessState extends DashboardState {
  final DashboardModel dashboard;

  const DashboardSuccessState({this.dashboard});

  @override
  List<Object> get props => [dashboard];
}

class DashboardFailedState extends DashboardState {
  @override
  List<Object> get props => [];
}