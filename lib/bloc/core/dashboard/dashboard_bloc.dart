import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/models/dashboard_model.dart';
import 'package:packet_tea/data/services/apis/user_services.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {


  final UserServices _userServices = GetIt.I.get<UserServices>();


  DashboardBloc() : super(DashboardInitial());

  @override
  Stream<DashboardState> mapEventToState(
      DashboardEvent event,
      ) async* {
    if (event is DashboardFetchEvent) {
      yield* _fetchManureRecords(event);
    }else if(event is DashboardEstateChange){

    }
  }

  Stream<DashboardState> _fetchManureRecords(
      DashboardFetchEvent event) async* {
    yield DashboardInProgressState();
    try {
      final DashboardModel dashboard = await _userServices.fetchDashboard();
      yield DashboardSuccessState(dashboard: dashboard);
    } catch (error) {
      yield DashboardFailedState();
    }
  }

  //
  // Stream<DashboardState> _fetchEstateChage(
  //     DashboardEstateChange event) async* {
  //   try {
  //     final estateChange = await _userServices.f
  //     final DashboardModel dashbaord = await _userServices.fetchDashboard();
  //     yield DashboardSuccessState(dashboard: dashbaord);
  //   } catch (error) {
  //     yield DashboardFailedState();
  //   }
  // }
}
