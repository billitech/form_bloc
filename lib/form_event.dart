part of 'form_bloc.dart';


abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  bool? get stringify => true;
}

class StatusChanged extends FormEvent {
  final FormStatus status;

  const StatusChanged({required this.status});

  @override
  List<Object> get props => [status];

  @override
  String toString() =>
      "StatusChanged { status: $status }";
}

class FormSubmitted extends FormEvent {
  final FormStatus status;
  final bool resetForm;

  const FormSubmitted({required this.status, this.resetForm = false});

  @override
  List<Object> get props => [status, resetForm];

  @override
  String toString() =>
      "StatusChanged { status: $status, resetForm: $resetForm }";
}

class ValidateForm extends FormEvent {
  @override
  List<Object?> get props => [];
}

class ResetForm extends FormEvent {
  @override
  List<Object?> get props => [];
}

class FormValidationError extends FormEvent {

  final FormValidationException error;

  const FormValidationError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() =>
      "StatusChanged { error: $error }";
}

