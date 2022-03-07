part of 'form_handler_bloc.dart';

abstract class FormHandlerEvent extends Equatable {
  const FormHandlerEvent();

  @override
  bool? get stringify => true;
}

class ButtonPressed<T> extends FormHandlerEvent {
  final T form;

  const ButtonPressed(this.form);

  @override
  List<Object?> get props => [form];

  @override
  String toString() => 'LoginButtonPressed { form: $form }';
}

