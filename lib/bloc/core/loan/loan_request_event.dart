part of 'loan_request_bloc.dart';

abstract class LoanRequestEvent extends Equatable {
  const LoanRequestEvent();
  @override
  List<Object> get props => [];
}

// --
/// [LoanAmountField]
/// This changed event is the event that gets triggered when the
/// user change the loan amount text field.
class LoanAmountChanged extends LoanRequestEvent {
  final LoanAmountField loanAmount;

  const LoanAmountChanged({this.loanAmount});

  @override
  List<Object> get props => [loanAmount];
}

/// [LoanDateField]
/// This changed event is the event that gets triggered when the
/// user change the loan date field.
class LoanDateChanged extends LoanRequestEvent {
  final LoanDateField loanDate;

  const LoanDateChanged({this.loanDate});

  @override
  List<Object> get props => [loanDate];
}


/// [LoanNotesField]
/// This changed event is the event that gets triggered when the
/// user change the loan notes text field.
class LoanNotesChanged extends LoanRequestEvent {
  final LoanNotesField notes;

  const LoanNotesChanged({this.notes});

  @override
  List<Object> get props => [notes];
}

/// This changed event is the event that gets triggered when the
/// user change the loan request is submitted.
class LoanRequestSubmitted extends LoanRequestEvent {
  @override
  List<Object> get props => [];
}