part of 'manure_request_bloc.dart';

@immutable
class ManureRequestState extends Equatable {
  final ManureWeightField weightField;
  final ManureContactField contactField;
  final ManureTypeField typeField;

  /// Overall form status
  final FormzStatus status;

  const ManureRequestState({
    this.weightField,
    this.contactField,
    this.typeField,
    this.status,
  });

  /// A quick and easy copy with function to handle deep coping
  /// [this] form state object.
  ManureRequestState copyWith({
    ManureWeightField weightField,
    ManureContactField contactField,
    ManureTypeField typeField,
    FormzStatus status,
  }) {
    return ManureRequestState(
      weightField: weightField ?? this.weightField,
      contactField: contactField ?? this.contactField,
      typeField: typeField ?? this.typeField,
      status: status ?? this.status,
    );
  }

  /// This function will help you to remove and replace a certain field
  /// from this form. [T] is the type of the value that you want to
  /// remove. It check its instance with a predicate.
  List<FormzInput<dynamic, dynamic>> allFormFieldsExcept<T>({FormzInput<dynamic, dynamic> andReplaceItWith}) {
    var list = <FormzInput<dynamic, dynamic>>[
      weightField,
      contactField,
      typeField,
    ].where((element) => element.runtimeType != T).toList();
    list.add(andReplaceItWith);
    return list;
  }

  @override
  List<Object> get props => [
    weightField,
    contactField,
    typeField,
    status,
  ];
}
