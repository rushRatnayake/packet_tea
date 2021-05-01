part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class DashboardFetchEvent extends DashboardEvent {
  @override
  List<Object> get props => [];
}

class DashboardEstateChange extends DashboardEvent {

  final String selectedEstateID;
  final String selectedEstateName;

  const DashboardEstateChange(this.selectedEstateID,this.selectedEstateName);
  @override
  List<Object> get props => [selectedEstateID,selectedEstateName];
}