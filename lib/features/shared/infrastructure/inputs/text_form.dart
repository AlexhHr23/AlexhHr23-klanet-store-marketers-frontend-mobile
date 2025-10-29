import 'package:formz/formz.dart';

// Define input validation errors
enum TextFormError { empty, length}

// Extend FormzInput and provide the input type and error type.
class TextFormInput extends FormzInput<String, TextFormError> {
  // static final RegExp passwordRegExp = RegExp(r'^[a-zA-Z]+$');

  // Call super.pure to represent an unmodified form input.
  const TextFormInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const TextFormInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TextFormError.empty) return 'El campo es requerido';
    if (displayError == TextFormError.length) {
      return 'Debe de tener al menos 3 caracteres';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TextFormError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TextFormError.empty;
    if (value.length < 3) return TextFormError.length;

    return null;
  }
}
