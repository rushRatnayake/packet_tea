import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/bloc/core/loan/load_request_fields.dart';
import 'package:packet_tea/data/services/apis/loan_services.dart';

part 'loan_request_event.dart';
part 'loan_request_state.dart';

class LoanRequestBloc extends Bloc<LoanRequestEvent, LoanRequestState> {
  static final LoanServices _loanServices = GetIt.I.get<LoanServices>();

  LoanRequestBloc() : super(createInitialState());

  static LoanRequestState createInitialState() {
    return LoanRequestState(
      loanAmountField: LoanAmountField.pure(""),
      loanDateField: LoanDateField.pure(DateTime.now()),
      loanNotesField: LoanNotesField.pure(""),
      status: FormzStatus.invalid,
    );
  }

  @override
  Stream<LoanRequestState> mapEventToState(
    LoanRequestEvent event,
  ) async* {
    if(event is LoanAmountChanged){
      yield* _mapLoanAmountChangedEToS(event);
    } else if(event is LoanDateChanged){
      yield* _mapLoanDateChangedEToS(event);
    } else if(event is LoanNotesChanged){
      yield* _mapLoanNotesChangedEToS(event);
    } else if(event is LoanRequestSubmitted){
      yield* _submitFormEToS(event);
    }
  }

  /// Related to [LoanAmountField]
  Stream<LoanRequestState> _mapLoanAmountChangedEToS(
      LoanAmountChanged event) async* {
    final newValue = LoanAmountField.dirty(event.loanAmount.value);
    yield state.copyWith(
      loanAmountField:
      newValue.valid ? LoanAmountField.pure(event.loanAmount.value) : newValue,
      status: Formz.validate(
          state.allFormFieldsExcept<LoanAmountField>(andReplaceItWith: newValue)),
    );
  }

  /// Related to [LoanDateField]
  Stream<LoanRequestState> _mapLoanDateChangedEToS(
      LoanDateChanged event) async* {
    final newValue = LoanDateField.dirty(event.loanDate.value);
    yield state.copyWith(
      loanDateField:
      newValue.valid ? LoanDateField.pure(event.loanDate.value) : newValue,
      status: Formz.validate(
          state.allFormFieldsExcept<LoanDateField>(andReplaceItWith: newValue)),
    );
  }

  /// Related to [LoanNotesField]
  Stream<LoanRequestState> _mapLoanNotesChangedEToS(
      LoanNotesChanged event) async* {
    final newValue = LoanNotesField.dirty(event.notes.value);
    yield state.copyWith(
      loanNotesField:
      newValue.valid ? LoanNotesField.pure(event.notes.value) : newValue,
      status: Formz.validate(
          state.allFormFieldsExcept<LoanNotesField>(andReplaceItWith: newValue)),
    );
  }

  Stream<LoanRequestState> _submitFormEToS(LoanRequestSubmitted event) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {

      bool successful = await _loanServices.requestLoan(
          state.loanAmountField.value,
          state.loanDateField.value,
          state.loanNotesField.value);

      if (successful) {
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } else {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } catch (error) {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}
