part of 'loan_request_bloc.dart';

@immutable
class LoanRequestState extends Equatable {
  final LoanAmountField loanAmountField;
  final LoanDateField loanDateField;
  final LoanNotesField loanNotesField;

  /// Overall form status
  final FormzStatus status;

  const LoanRequestState({
    this.loanAmountField,
    this.loanDateField,
    this.loanNotesField,
    this.status,
  });

  /// A quick and easy copy with function to handle deep coping
  /// [this] form state object.
  LoanRequestState copyWith({
    LoanAmountField loanAmountField,
    LoanDateField loanDateField,
    LoanNotesField loanNotesField,
    FormzStatus status,
  }) {
    return LoanRequestState(
      loanAmountField: loanAmountField ?? this.loanAmountField,
      loanDateField: loanDateField ?? this.loanDateField,
      loanNotesField: loanNotesField ?? this.loanNotesField,
      status: status ?? this.status,
    );
  }

  /// This function will help you to remove and replace a certain field
  /// from this form. [T] is the type of the value that you want to
  /// remove. It check its instance with a predicate.
  List<FormzInput<dynamic, dynamic>> allFormFieldsExcept<T>({FormzInput<dynamic, dynamic> andReplaceItWith}) {
    var list = <FormzInput<dynamic, dynamic>>[
      loanAmountField,
      loanDateField,
      loanNotesField,
    ].where((element) => element.runtimeType != T).toList();
    list.add(andReplaceItWith);
    return list;
  }

  @override
  List<Object> get props => [
    loanAmountField,
    loanDateField,
    loanNotesField,
    status,
  ];
}
