import 'package:formz/formz.dart';

enum RepeatPasswordError { empty, mismatch }

class RepeatPassword extends FormzInput<String, RepeatPasswordError> {
  final String password; // contraseña original para comparar

  // Constructor puro
  const RepeatPassword.pure({this.password = ''}) : super.pure('');

  // Constructor sucio
  const RepeatPassword.dirty({required this.password, String value = ''})
    : super.dirty(value);

  String? get errorMessage {
    if (isPure || isValid) return null;
    if (error == RepeatPasswordError.empty) return 'El campo es requerido';
    if (error == RepeatPasswordError.mismatch) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  // Validador
  @override
  RepeatPasswordError? validator(String value) {
    if (value.isEmpty) return RepeatPasswordError.empty;
    if (value != password) return RepeatPasswordError.mismatch;
    return null;
  }
}
