import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/models/dashboard_model.dart';
import 'package:packet_tea/data/services/apis/user_services.dart';

part 'estate_event.dart';
part 'estate_state.dart';

class EstateBloc extends Bloc<EstateEvent, EstateState> {

  final UserServices _userServices = GetIt.I.get<UserServices>();


  EstateBloc() : super(EstateInitial());

  @override
  Stream<EstateState> mapEventToState(
      EstateEvent event,
      ) async* {
    if (event is EstatesFetchEvent) {
      yield* _fetchEstates(event);
    }
  }

  Stream<EstateState> _fetchEstates(
      EstateEvent event) async* {
    yield EstateInProgress();
    try {
      final List<EstateModel> estates = await _userServices.fetchUserEstates();
      yield EstateSuccess(estates: estates);
    } catch (error) {
      yield EstateFailed();
    }
  }
}
