part of 'form_handler_bloc.dart';

enum FormHandlerStatus { initial, loading, failure, success }

class FormHandlerState<R> extends Equatable {
  final FormHandlerStatus status;
  final R? successData;
  final String? error;
  final FormValidationException? validationError;

  const FormHandlerState(
      {required this.status,
      this.successData,
      this.error,
      this.validationError});

  factory FormHandlerState.initial() =>
      FormHandlerState(status: FormHandlerStatus.initial);

  copyWith(
      {FormHandlerStatus? status,
      Optional<R?> successData = const Optional(),
      Optional<String?> error = const Optional(),
      Optional<FormValidationException?> validationError = const Optional()}) {
    return FormHandlerState(
        status: status ?? this.status,
        successData: successData.isValid ? successData.value : this.successData,
        error: error.isValid ? error.value : this.error,
        validationError: validationError.isValid
            ? validationError.value
            : this.validationError);
  }

  get isInitial => status == FormHandlerStatus.initial;

  get isLoading => status == FormHandlerStatus.loading;

  get isSuccess => status == FormHandlerStatus.success && successData != null;

  get isFailure => status == FormHandlerStatus.failure && error != null;

  get isValidationFailure =>
      status == FormHandlerStatus.failure && validationError != null;

  @override
  List<Object?> get props => [status, successData, error, validationError];
}
