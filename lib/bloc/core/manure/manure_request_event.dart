part of 'manure_request_bloc.dart';

abstract class ManureRequestEvent extends Equatable {
  const ManureRequestEvent();
  @override
  List<Object> get props => [];
}
// --
/// [ManureWeightField]
/// This changed event is the event that gets triggered when the
/// user change the Manure Weight text field.
class ManureWeightChanged extends ManureRequestEvent {
  final ManureWeightField weight;

  const ManureWeightChanged({this.weight});

  @override
  List<Object> get props => [weight];
}

/// [ManureContactField]
/// This changed event is the event that gets triggered when the
/// user change the Manure contact field.
class ManureContactChanged extends ManureRequestEvent {
  final ManureContactField contactField;

  const ManureContactChanged({this.contactField});

  @override
  List<Object> get props => [contactField];
}


/// [ManureTypeField]
/// This changed event is the event that gets triggered when the
/// user change the manure type field.
class ManureTypeChanged extends ManureRequestEvent {
  final ManureTypeField typeField;

  const ManureTypeChanged({this.typeField});

  @override
  List<Object> get props => [typeField];
}

/// This changed event is the event that gets triggered when the
/// user change the loan request is submitted.
class ManureRequestSubmitted extends ManureRequestEvent {
  @override
  List<Object> get props => [];
}