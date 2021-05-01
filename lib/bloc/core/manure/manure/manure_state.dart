part of 'manure_bloc.dart';

abstract class ManureState extends Equatable {
  const ManureState();
}

class ManureInitial extends ManureState {
  @override
  List<Object> get props => [];
}

class ManureInProgressState extends ManureState {
  @override
  List<Object> get props => [];
}

class ManureSuccessState extends ManureState {
  final ManureParentModel manure;

  const ManureSuccessState({this.manure});

  @override
  List<Object> get props => [manure];
}

class ManureFailedState extends ManureState {
  @override
  List<Object> get props => [];
}