import 'package:equatable/equatable.dart';

class FormValidationException extends Equatable{

  final Map<String, String> error;
  final String message;

  const FormValidationException({required this.error, required this.message});

  @override
  List<Object?> get props => [error, message];

  @override
  String toString() => "FormValidationException { message: $message, error: $error}";
}