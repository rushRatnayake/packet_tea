part of 'loans_bloc.dart';

abstract class LoansEvent extends Equatable {
  const LoansEvent();
}
class LoansFetchEvent extends LoansEvent {
  @override
  List<Object> get props => [];
}


class LoansDeleteEvent extends LoansEvent{

  final String deleteItemId;

  const LoansDeleteEvent({this.deleteItemId});

  @override
  List<Object> get props => [deleteItemId];
}