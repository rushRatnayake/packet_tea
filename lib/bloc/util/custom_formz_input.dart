import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

abstract class CustomFormzInput<T, E> extends FormzInput<T, E> implements Equatable, FieldErrorUnWrapper {
  const CustomFormzInput.dirty(T value) : super.dirty(value);
  const CustomFormzInput.pure(T value) : super.pure(value);

  @override
  List<Object> get props => [this.value];

  @override
  bool get stringify => true;
}

abstract class FieldErrorUnWrapper {
  String getErrorMessageIfExists();
}