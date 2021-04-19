import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/bloc/core/manure/manure_request_fields.dart';
import 'package:packet_tea/data/services/apis/manure_services.dart';

part 'manure_request_event.dart';
part 'manure_request_state.dart';

class ManureRequestBloc extends Bloc<ManureRequestEvent, ManureRequestState> {

  static final ManureServices _manureServices = GetIt.I.get<ManureServices>();
  ManureRequestBloc() : super(createInitialState());

  static ManureRequestState createInitialState() {
    return ManureRequestState(
      weightField: ManureWeightField.pure(""),
      contactField: ManureContactField.pure(""),
      typeField: ManureTypeField.pure(""),
      status: FormzStatus.invalid,
    );
  }
  @override
  Stream<ManureRequestState> mapEventToState(
    ManureRequestEvent event,
  ) async* {
    if(event is ManureWeightChanged){
      yield* _mapWeightChangedEToS(event);
    }else if (event is ManureContactChanged){
      yield* _mapContactChangedEToS(event);
    }else if (event is ManureTypeChanged){
      yield* _mapTypeChangedEToS(event);
    }else if (event is ManureRequestSubmitted){
      yield* _submitFormEToS(event);
    }
  }

  /// Related to [ManureWeightField]
  Stream<ManureRequestState> _mapWeightChangedEToS(
      ManureWeightChanged event) async* {
    final newValue = ManureWeightField.dirty(event.weight.value);
    yield state.copyWith(
      weightField:
      newValue.valid ? ManureWeightField.pure(event.weight.value) : newValue,
      status: Formz.validate(
          state.allFormFieldsExcept<ManureWeightField>(andReplaceItWith: newValue)),
    );
  }

  /// Related to [ManureContactField]
  Stream<ManureRequestState> _mapContactChangedEToS(
      ManureContactChanged event) async* {
    final newValue = ManureContactField.dirty(event.contactField.value);
    yield state.copyWith(
      contactField:
      newValue.valid ? ManureContactField.pure(event.contactField.value) : newValue,
      status: Formz.validate(
          state.allFormFieldsExcept<ManureContactField>(andReplaceItWith: newValue)),
    );
  }

  /// Related to [ManureTypeField]
  Stream<ManureRequestState> _mapTypeChangedEToS(
      ManureTypeChanged event) async* {
    final newValue = ManureTypeField.dirty(event.typeField.value);
    yield state.copyWith(
      typeField:
      newValue.valid ? ManureTypeField.pure(event.typeField.value) : newValue,
      status: Formz.validate(
          state.allFormFieldsExcept<ManureTypeField>(andReplaceItWith: newValue)),
    );
  }

  Stream<ManureRequestState> _submitFormEToS(ManureRequestSubmitted event) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {

      bool successful = await _manureServices.requestManure(
          state.weightField.value,
          state.contactField.value,
          state.typeField.value);

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
