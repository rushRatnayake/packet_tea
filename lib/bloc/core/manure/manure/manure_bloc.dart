import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/models/manure_model.dart';
import 'package:packet_tea/data/services/apis/manure_services.dart';

part 'manure_event.dart';
part 'manure_state.dart';

class ManureBloc extends Bloc<ManureEvent, ManureState> {
  final ManureServices _manureServices = GetIt.I.get<ManureServices>();


  ManureBloc() : super(ManureInitial());

  @override
  Stream<ManureState> mapEventToState(
      ManureEvent event,
      ) async* {
    if (event is ManureFetchEvent) {
      yield* _fetchManureRecords(event);
    }
  }

  Stream<ManureState> _fetchManureRecords(
      ManureEvent event) async* {
    yield ManureInProgressState();
    try {
      final ManureParentModel manure = await _manureServices.fetchManureByID();
      yield ManureSuccessState(manure: manure);
    } catch (error) {
      yield ManureFailedState();
    }
  }
}
