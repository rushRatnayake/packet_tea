part of 'harvest_bloc.dart';

abstract class HarvestState extends Equatable {
  const HarvestState();
}

class HarvestInitial extends HarvestState {
  @override
  List<Object> get props => [];
}

class HarvestInProgressState extends HarvestState {
  @override
  List<Object> get props => [];
}

class HarvestSuccessState extends HarvestState {
  final HarvestParentModel harvest;

  const HarvestSuccessState({this.harvest});

  @override
  List<Object> get props => [harvest];
}

class HarvestFailedState extends HarvestState {
  @override
  List<Object> get props => [];
}