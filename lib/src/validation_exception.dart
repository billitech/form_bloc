class FormValidationException {

  final Map<String, String> error;
  final String  message;

  const FormValidationException({required this.error, required this.message});
}