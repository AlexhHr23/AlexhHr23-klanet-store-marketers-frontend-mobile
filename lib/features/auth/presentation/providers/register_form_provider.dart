import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../shared/infrastructure/inputs/inputs.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((
      ref,
    ) {
      return RegisterFormNotifier();
    });

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  onNameChange(String value) {
    final newName = TextInput.dirty(value);
    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([
        newName,
        state.lastName,
        state.email,
        state.password,
        state.repeatPassword,
        ?state.code,
      ]),
    );
  }

  onLastNameChange(String value) {
    final newLastName = TextInput.dirty(value);
    state = state.copyWith(
      lastName: newLastName,
      isValid: Formz.validate([
        newLastName,
        state.name,
        state.email,
        state.password,
        state.repeatPassword,
        ?state.code,
      ]),
    );
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([
        newEmail,
        state.name,
        state.lastName,
        state.password,
        state.repeatPassword,
        ?state.code,
      ]),
    );
  }

  onPhoneChange(String phone, String isoCode, String countryCode) {
    final newPhone = PhoneNumber.dirty(phone);
    state = state.copyWith(
      phoneNumber: newPhone,
      telIso: isoCode,
      telCode: countryCode,
      isValid: Formz.validate([
        newPhone,
        state.name,
        state.lastName,
        state.email,
        state.password,
        state.repeatPassword,
        ?state.code,
      ]),
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([
        state.name,
        state.lastName,
        state.email,
        newPassword,
        state.repeatPassword,
        ?state.code,
      ]),
    );
  }

  onRepeatPasswordChange(String value) {
    final newRepeatPassword = RepeatPassword.dirty(
      password: state.password.value,
      value: value,
    );
    state = state.copyWith(
      repeatPassword: newRepeatPassword,
      isValid: Formz.validate([
        state.name,
        state.lastName,
        state.email,
        state.password,
        newRepeatPassword,
        ?state.code,
      ]),
    );
  }

  onCodeChange(String value) {
    final newCode = Code.dirty(value);
    state = state.copyWith(
      code: newCode,
      isValid: Formz.validate([
        newCode,
        state.name,
        state.lastName,
        state.email,
        state.password,
        state.repeatPassword,
      ]),
    );
  }

  onFormSubmit() {
    state = state.copyWith(isFormPosted: true);
    _touchEveryField();
    if (!state.isValid) return;
    print(state);
  }

  _touchEveryField() {
    final name = TextInput.dirty(state.name.value);
    final lastName = TextInput.dirty(state.lastName.value);
    final email = Email.dirty(state.email.value);
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = RepeatPassword.dirty(
      password: state.password.value,
      value: state.repeatPassword.value,
    );
    final code = Code.dirty(state.code?.value ?? '');

    state = state.copyWith(
      name: name,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      repeatPassword: repeatPassword,
      code: code,
      isValid: Formz.validate([
        name,
        lastName,
        email,
        phoneNumber,
        password,
        repeatPassword,
        code,
      ]),
    );
  }
}

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final TextInput name;
  final TextInput lastName;
  final Email email;
  final PhoneNumber phoneNumber;
  final String telIso;
  final String telCode;
  final Password password;
  final RepeatPassword repeatPassword;
  final Code? code;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const TextInput.pure(),
    this.lastName = const TextInput.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.telIso = '',
    this.telCode = '',
    this.password = const Password.pure(),
    this.repeatPassword = const RepeatPassword.pure(),
    this.code = const Code.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    TextInput? name,
    TextInput? lastName,
    Email? email,
    PhoneNumber? phoneNumber,
    String? telIso,
    String? telCode,
    Password? password,
    RepeatPassword? repeatPassword,
    Code? code,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    telIso: telIso ?? this.telIso,
    telCode: telCode ?? this.telCode,
    password: password ?? this.password,
    repeatPassword: repeatPassword ?? this.repeatPassword,
    code: code ?? this.code,
  );
  @override
  String toString() {
    return '''
    RegisterFormState:
      isPosting: $isPosting,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      name: $name,
      lastName: $lastName,
      email: $email,
      phoneNumber: $phoneNumber,
      telIso: $telIso,
      telCode: $telCode,
      password: $password,
      repeatPassword: $repeatPassword,
      code: $code,
    }
    ''';
  }
}
