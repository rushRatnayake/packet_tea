part of 'estate_bloc.dart';

abstract class EstateState extends Equatable {
  const EstateState();
}

class EstateInitial extends EstateState {
  @override
  List<Object> get props => [];
}

class EstateInProgress extends EstateState {
  @override
  List<Object> get props => [];
}


class EstateSuccess extends EstateState {
  final List<EstateModel> estates;

  const EstateSuccess({this.estates});
  @override
  List<Object> get props => [];
}


class EstateFailed extends EstateState {
  @override
  List<Object> get props => [];
}
