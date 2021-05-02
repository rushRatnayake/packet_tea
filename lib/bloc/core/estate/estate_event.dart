part of 'estate_bloc.dart';

abstract class EstateEvent extends Equatable {
  const EstateEvent();
}

class EstatesFetchEvent extends EstateEvent {
  @override
  List<Object> get props => [];
}


abstract class EstateSelectEvent extends EstateEvent {
  final String selectedEstateID;

  const EstateSelectEvent({this.selectedEstateID});

  @override
  List<Object> get props => [selectedEstateID];}
