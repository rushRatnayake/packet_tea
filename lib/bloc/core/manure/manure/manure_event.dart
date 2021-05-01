part of 'manure_bloc.dart';

abstract class ManureEvent extends Equatable {
  const ManureEvent();
}

class ManureFetchEvent extends ManureEvent {
  @override
  List<Object> get props => [];
}

class ManureDeleteEvent extends ManureEvent{

  final String deleteItemId;

  const ManureDeleteEvent({this.deleteItemId});

  @override
  List<Object> get props => [deleteItemId];
}