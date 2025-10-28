import 'package:formz/formz.dart';

enum GoogleAnalyticsError { invalid, length }

class GoogleAnalytics extends FormzInput<String, GoogleAnalyticsError> {
  const GoogleAnalytics.pure() : super.pure('');
  const GoogleAnalytics.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (value.isEmpty) return null;

    if (displayError == GoogleAnalyticsError.length) {
      return 'El ID debe tener 11 caracteres';
    }
    if (displayError == GoogleAnalyticsError.invalid) {
      return 'El ID debe tener el formato G-XXXXXXXXXXX';
    }

    return null;
  }

  @override
  GoogleAnalyticsError? validator(String value) {
    if (value.isEmpty) return null;

    // Validar longitud total
    if (value.length != 11) {
      return GoogleAnalyticsError.length;
    }

    // Validar formato: G- seguido de 9 caracteres alfanuméricos en mayúsculas
    if (!RegExp(r'^G-[A-Z0-9]{9}$').hasMatch(value)) {
      return GoogleAnalyticsError.invalid;
    }

    return null;
  }
}
