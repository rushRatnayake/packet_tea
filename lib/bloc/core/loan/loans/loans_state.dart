part of 'loans_bloc.dart';

abstract class LoansState extends Equatable {
  const LoansState();
}

class LoansInitial extends LoansState {
  @override
  List<Object> get props => [];
}

class LoansInProgressState extends LoansState {
  @override
  List<Object> get props => [];
}

class LoansSuccessState extends LoansState {
  final LoanParentModel loans;

  const LoansSuccessState({this.loans});

  @override
  List<Object> get props => [loans];
}

class LoansFailedState extends LoansState {
  @override
  List<Object> get props => [];
}