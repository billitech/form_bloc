part of 'form_bloc.dart';

enum FormStatus {
  valid,
  invalid,
}

class FormState extends Equatable {
  final FormStatus status;
  final bool submitted;

  const FormState({required this.status, required this.submitted});

  factory FormState.initial() => const FormState(
        status: FormStatus.invalid,
        submitted: false,
      );

  copyWith({FormStatus? status, bool? submitted}) {
    return FormState(
      status: status ?? this.status,
      submitted: submitted ?? this.submitted,
    );
  }

  get valid => status == FormStatus.valid;

  get invalid => status == FormStatus.invalid;

  @override
  List<Object?> get props => [status, submitted];

  @override
  String toString() =>
      "FormState {status: $status, submitted: $submitted, valid: $valid, invalid: $invalid}";
}
