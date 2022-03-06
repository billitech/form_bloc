class FormValidationException {

  final Map<String, String> error;
  final String  message;

  FormValidationException({required this.error, required this.message});
}