import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/models/harvest_model.dart';
import 'package:packet_tea/data/services/apis/harvest_services.dart';

part 'harvest_event.dart';
part 'harvest_state.dart';

class HarvestBloc extends Bloc<HarvestEvent, HarvestState> {
  final HarvestService _harvestService = GetIt.I.get<HarvestService>();

  HarvestBloc() : super(HarvestInitial());

  @override
  Stream<HarvestState> mapEventToState(
      HarvestEvent event,
      ) async* {
    if (event is HarvestFetchEvent) {
      yield* _fetchManureRecords(event);
    }
  }

  Stream<HarvestState> _fetchManureRecords(
      HarvestEvent event) async* {
    yield HarvestInProgressState();
    try {
      final HarvestParentModel harvest = await _harvestService.fetchHarvestByEstateID();
      yield HarvestSuccessState(harvest: harvest);
    } catch (error) {
      yield HarvestFailedState();
    }
  }
}
