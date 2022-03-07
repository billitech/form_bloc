part of 'input_bloc.dart';

class InputState<V extends Object, E extends Object> extends Equatable {
  final V _value;
  final E? _error;
  final bool _initial;

  const InputState({required V value, E? error, required bool initial})
      : _value = value,
        _error = error,
        _initial = initial;

  get value => _value;

  get initial => _initial;

  get error => _error;

  get valid => error == null;

  get invalid => error != null;

  copyWith({V? value, Optional<E?> error = const Optional(), bool? initial}) {
    return InputState(
      value: value ?? _value,
      error: error.isValid ? error.value : _error,
      initial: initial ?? _initial,
    );
  }

  @override
  List<Object> get props => [value, error, initial];

  @override
  String toString() =>
      "InputState{ value: $value, error: $error, initial: $initial, invalid: $valid, invalid: $invalid }";
}
