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

  copyWith({V? value, E? error, bool? initial, bool? emptyError}) {
    return InputState(
      value: value ?? _value,
      error: (emptyError != null && emptyError) ? null : (error ?? _error),
      initial: initial ?? _initial,
    );
  }

  @override
  List<Object> get props => [value, error, initial];

  @override
  String toString() =>
      "InputState{ value: $value, error: $error, initial: $initial, invalid: $valid, invalid: $invalid }";
}
