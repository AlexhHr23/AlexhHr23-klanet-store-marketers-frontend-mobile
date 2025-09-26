import 'package:formz/formz.dart';

// Define input validation errors
enum TextError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class TextInput extends FormzInput<String, TextError> {
  static final RegExp passwordRegExp = RegExp(r'^[a-zA-Z]+$');

  // Call super.pure to represent an unmodified form input.
  const TextInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const TextInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TextError.empty) return 'El campo es requerido';
    if (displayError == TextError.length) {
      return 'Debe de tener al menos 3 caracteres';
    }
    if (displayError == TextError.format) return 'Debe de tener solo letras';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TextError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TextError.empty;
    if (value.length < 3) return TextError.length;
    if (!passwordRegExp.hasMatch(value)) return TextError.format;

    return null;
  }
}
