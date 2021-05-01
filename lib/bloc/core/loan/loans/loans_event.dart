part of 'loans_bloc.dart';

abstract class LoansEvent extends Equatable {
  const LoansEvent();
}
class LoansFetchEvent extends LoansEvent {
  @override
  List<Object> get props => [];
}