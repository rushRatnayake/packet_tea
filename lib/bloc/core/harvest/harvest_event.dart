part of 'harvest_bloc.dart';


abstract class HarvestEvent extends Equatable {
  const HarvestEvent();
}

class HarvestFetchEvent extends HarvestEvent {
  @override
  List<Object> get props => [];
}