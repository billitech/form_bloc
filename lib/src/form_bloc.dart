import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'input/input_bloc.dart';
import 'subscription_container.dart';
import 'validation_exception.dart';

part 'form_event.dart';
part 'form_state.dart';

abstract class FormBloc extends Bloc<FormEvent, FormState> {
  List<InputBloc<dynamic, dynamic>> get fields => [];

  final subscriptionsContainer = SubscriptionsContainer();

  final List<InputBloc<dynamic, dynamic>> invalidFields = [];

  FormBloc() : super(FormState.initial()) {
    initializeFields();
    on<StatusChanged>(_onStatusChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<ValidateForm>(_onValidateForm);
    on<ResetForm>(_onResetForm);
    on<FormValidationError>(_onFormValidationError);
  }

  initializeFields() {
    for (var field in fields) {
      subscriptionsContainer.add = field.stream.listen((state) {
        _validateField(field);
      });
    }
  }

  _validateField(InputBloc<dynamic, dynamic> field) {
    invalidFields.removeWhere((element) => field.name == element.name);

    if (field.state.invalid) {
      emitStatusChanged(FormStatus.invalid);
      invalidFields.add(field);
    } else {
      if (invalidFields.isEmpty) {
        emitStatusChanged(FormStatus.valid);
      }
    }
  }

  _onStatusChanged(StatusChanged event, Emitter<FormState> emit) {
    emit(state.copyWith(
      status: event.status,
    ));
  }

  _onFormSubmitted(FormSubmitted event, Emitter<FormState> emit) {
    emit(state.copyWith(
      status: event.status,
      submitted: true,
    ));

    if (event.resetForm) {
      resetForm();
    }
  }

  _onValidateForm(ValidateForm event, Emitter<FormState> emit) {
    validateForm();
  }

  _onResetForm(ResetForm event, Emitter<FormState> emit) {
    resetForm();
  }

  _onFormValidationError(FormValidationError event, Emitter<FormState> emit) {
    emit(state.copyWith(
      status: FormStatus.valid,
    ));
  }

  resetForm() {
    for (var field in fields) {
      field.emitResetInput();
    }
  }

  validateForm() {
    for (var field in fields) {
      _validateField(field);
    }
  }

  onValidationError(FormValidationException error) {
    for (var key in error.error.keys) {
      final field = fields.firstWhereOrNull((field) => field.name == key);
      if (field != null) {
        field.emitInputValidationError(error.error[key]);
      }
    }
  }

  emitValidationError(FormValidationException error) {
    add(FormValidationError(error: error));
  }

  emitValidateForm() {
    add(ValidateForm());
  }

  emitStatusChanged(FormStatus status) {
    add(StatusChanged(status: status));
  }

  emitFormSubmitted(FormStatus status, bool resetForm) {
    add(FormSubmitted(status: status, resetForm: resetForm));
  }

  emitResetForm() {
    add(ResetForm());
  }

  @override
  close() {
    subscriptionsContainer.cancel();
    invalidFields.removeRange(0, invalidFields.length);
    return super.close();
  }
}
