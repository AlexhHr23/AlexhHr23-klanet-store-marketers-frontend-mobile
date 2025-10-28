import 'package:formz/formz.dart';

enum ClarityError { invalid, length }

class Clarity extends FormzInput<String, ClarityError> {
  const Clarity.pure() : super.pure('');
  const Clarity.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (value.isEmpty) return null;

    if (displayError == ClarityError.length) {
      return 'El ID de Clarity debe tener 12 caracteres';
    }
    if (displayError == ClarityError.invalid) {
      return 'El ID de Clarity debe ser alfanumérico';
    }

    return null;
  }

  @override
  ClarityError? validator(String value) {
    if (value.isEmpty) return null;

    if (value.length != 12) {
      return ClarityError.length;
    }

    if (!RegExp(r'^[a-z0-9]+$').hasMatch(value)) {
      return ClarityError.invalid;
    }

    return null;
  }
}
