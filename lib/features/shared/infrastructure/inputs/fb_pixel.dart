import 'package:formz/formz.dart';

enum FacebookPixelError { invalid, length }

class FacebookPixel extends FormzInput<String, FacebookPixelError> {
  const FacebookPixel.pure() : super.pure('');
  const FacebookPixel.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (value.isEmpty) return null;

    if (displayError == FacebookPixelError.length) {
      return 'El ID debe tener 15 o 16 caracteres';
    }
    if (displayError == FacebookPixelError.invalid) {
      return 'El ID solo debe contener números';
    }

    return null;
  }

  @override
  FacebookPixelError? validator(String value) {
    if (value.isEmpty) return null;

    if (value.length != 15 && value.length != 16) {
      return FacebookPixelError.length;
    }

    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return FacebookPixelError.invalid;
    }

    return null;
  }
}
