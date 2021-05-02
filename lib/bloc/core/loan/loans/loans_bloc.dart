import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/models/loan_model.dart';
import 'package:packet_tea/data/services/apis/loan_services.dart';

part 'loans_event.dart';
part 'loans_state.dart';

class LoansBloc extends Bloc<LoansEvent, LoansState> {
  final LoanServices _loanService = GetIt.I.get<LoanServices>();

  LoansBloc() : super(LoansInitial());

  @override
  Stream<LoansState> mapEventToState(
      LoansEvent event,
      ) async* {
    if (event is LoansFetchEvent) {
      yield* _mapFetchLoansEventToState(event);
    }else if(event is LoansDeleteEvent){
      yield* _deleteLoanRecords(event);
    }
  }

  Stream<LoansState> _mapFetchLoansEventToState(
      LoansEvent event) async* {
    yield LoansInProgressState();
    try {
      final LoanParentModel loans = await _loanService.fetchLoansByEstateID();
      yield LoansSuccessState(loans: loans);
    } catch (error) {
      yield LoansFailedState();
    }
  }

  Stream<LoansState> _deleteLoanRecords(
      LoansDeleteEvent event) async* {

    try {
      final bool successful = await _loanService.deleteLoanByID(event.deleteItemId);
      if(successful){
        yield LoansInProgressState();
        final LoanParentModel loans = await _loanService.fetchLoansByEstateID();
        yield LoansSuccessState(loans: loans);
      }else{
        yield LoansFailedState();
      }
    } catch (error) {
      yield LoansFailedState();
    }
  }

}
