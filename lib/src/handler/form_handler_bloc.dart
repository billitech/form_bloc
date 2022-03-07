import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_bloc/src/optional.dart';
import '../../form_bloc.dart';
import '../validation_exception.dart';

part 'form_handler_event.dart';

part 'form_handler_state.dart';

abstract class FormHandlerBloc<F extends FormBloc, R>
    extends Bloc<FormHandlerEvent, FormHandlerState<R>> {
  FormHandlerBloc() : super(FormHandlerState.initial()) {
    on<ButtonPressed<F>>(_onButtonPressed);
  }

  _onButtonPressed(
      ButtonPressed<F> event, Emitter<FormHandlerState<R>> emit) async {
    emit(state.copyWith(status: FormHandlerStatus.loading));
    try {
      final res = await handleFormSubmission(event.form);
      emit(state.copyWith(
          status: FormHandlerStatus.success, successData: Optional.value(res)));
      event.form.emitFormSubmitted(FormStatus.valid, true);
    } catch (error) {
      if (error is FormValidationException) {
        emit(state.copyWith(
            status: FormHandlerStatus.failure,
            error: Optional.value(error.message),
            validationError: Optional.value(error)));
        event.form.emitValidationError(error);
      } else {
        emit(state.copyWith(
            status: FormHandlerStatus.failure,
            error: Optional.value(error.toString())));
        event.form.emitStatusChanged(FormStatus.invalid);
      }
    }
  }

  Future<R> handleFormSubmission(F form);

  emitButtonPressed(F form) {
    add(ButtonPressed(form));
  }
}
