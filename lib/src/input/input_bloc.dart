import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'input_event.dart';
part 'input_state.dart';

abstract class InputBloc<V extends Object, E extends Object>
    extends Bloc<InputEvent, InputState<V, E>> {
  final String name;
  final V initialValue;

  InputBloc({required this.name, required V value})
      : initialValue = value,
        super(InputState(
          value: value,
          initial: true,
        )) {
    on<InputChanged<V>>(_onInputChanged);
    on<InputUnFocused>(_onInputUnFocused);
    on<ResetInput>(_onResetInput);
    on<InputValidationError>(_onInputValidationError);
  }

  _onInputChanged(InputChanged<V> event, Emitter<InputState<V, E>> emit) {
    final error = validate(event.value);
    emit(state.copyWith(
        value: event.value, error: error, emptyError: error == null));
  }

  _onInputUnFocused(InputUnFocused event, Emitter<InputState<V, E>> emit) {
    final error = validate(state.value);
    emit(state.copyWith(
        initial: false, error: error, emptyError: error == null));
  }

  _onResetInput(ResetInput event, Emitter<InputState<V, E>> emit) {
    emit(state.copyWith(
      initial: true,
      value: initialValue,
    ));
  }

  _onInputValidationError(
      InputValidationError event, Emitter<InputState<V, E>> emit) {
    emit(state.copyWith(
      error: event.error,
      initial: false,
    ));
  }

  emitInputChanged(V value) {
    add(InputChanged<V>(value));
  }

  emitInputUnFocused() {
    add(InputUnFocused());
  }

  emitResetInput() {
    add(ResetInput());
  }

  emitInputValidationError(E error) {
    add(InputValidationError<E>(error));
  }

  E? validate(V value);
}
