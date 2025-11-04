import 'package:formz/formz.dart';

enum NumError { empty, invalid }

class NumInput extends FormzInput<int?, NumError> {
  const NumInput.pure() : super.pure(null);
  const NumInput.dirty([super.value]) : super.dirty();

  @override
  NumError? validator(int? value) {
    if (value == null) return NumError.empty;
    if (value <= 0) return NumError.invalid;
    return null;
  }

  String? get errorMessage {
    if (error == NumError.empty) {
      return 'El campo no puede estar vacío';
    } else if (error == NumError.invalid) {
      return 'El número debe ser mayor que 0';
    }
    return null;
  }
}
