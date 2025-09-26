import 'package:formz/formz.dart';

// Define input validation errors
enum PhoneError { empty, length }

// Extend FormzInput and provide the input type and error type.
class PhoneNumber extends FormzInput<String, PhoneError> {
  static final RegExp passwordRegExp = RegExp(r'^[a-zA-Z]+$');

  // Call super.pure to represent an unmodified form input.
  const PhoneNumber.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PhoneNumber.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PhoneError.empty) return 'El campo es requerido';
    if (displayError == PhoneError.length) {
      return 'Número de telefono no valido';
    }
    // if (displayError == PhoneNumber.format) return 'Debe de tener solo letras';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PhoneError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PhoneError.empty;
    if (value.length > 3 && value.length < 10) return PhoneError.length;

    return null;
  }
}
