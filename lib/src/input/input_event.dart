part of 'input_bloc.dart';

abstract class InputEvent extends Equatable {
  const InputEvent();

  @override
  bool get stringify => true;
}

class InputChanged<V extends Object> extends InputEvent {
  final V value;

  const InputChanged(this.value);

  @override
  List<Object> get props => [value];

  @override
  String toString() => "InputChanged { value: $value}";
}

class InputUnFocused extends InputEvent {
  @override
  List<Object> get props => [];
}

class ResetInput extends InputEvent {
  @override
  List<Object> get props => [];
}

class InputValidationError<E> extends InputEvent {
  final E error;

  const InputValidationError(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => "InputValidationError { error: $error}";
}
