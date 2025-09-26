import 'package:formz/formz.dart';

// Define input validation errors
enum CodeError { length }

// Extend FormzInput and provide the input type and error type.
class Code extends FormzInput<String, CodeError> {
  // static final RegExp passwordRegExp = RegExp(r'^[a-zA-Z]+$');

  // Call super.pure to represent an unmodified form input.
  const Code.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Code.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (value.isEmpty) return null;

    if (displayError == CodeError.length) return 'Mínimo 6 caracteres';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CodeError? validator(String value) {
    if (value.isEmpty) return null;
    if (value.length < 6) return CodeError.length;

    return null;
  }
}
