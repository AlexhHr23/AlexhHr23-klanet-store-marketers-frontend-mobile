import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:klanetmarketers/features/packages/presentation/presentation.dart';
import 'package:klanetmarketers/features/shared/infrastructure/inputs/inputs.dart';

final packageFormProvider = StateNotifierProvider.autoDispose
    .family<PackageFormNotifier, StoreFormState, String>((ref, country) {
      final createUpdateCallback = ref
          .watch(packageProvider.notifier)
          .createPackage;
      final countryCode = country;
      return PackageFormNotifier(
        onSubmitCallback: createUpdateCallback,
        countryCode: countryCode,
      );
    });

class PackageFormNotifier extends StateNotifier<StoreFormState> {
  final Future<bool> Function(
    String countryCode,
    Map<String, dynamic> packageLike,
  )?
  onSubmitCallback;
  final String countryCode = '';

  PackageFormNotifier({
    this.onSubmitCallback,
    required final String countryCode,
  }) : super(StoreFormState(country: countryCode));

  Future<void> reset() async {
    state = state.copyWith(name: TextFormInput.pure(), type: '1');
  }

  Future<String> onFormSubmit() async {
    _touchEverything();
    if (!state.isFormValid) return 'form';
    final packageLike = {
      "id_producto": 0,
      "nombre": state.name.value,
      "tipo": state.type,
    };

    try {
      // print(packageLike);
      final result = await onSubmitCallback!(state.country, packageLike);
      return result ? 'success' : 'error';
    } catch (e) {
      print('error: $e');
      return 'error';
    }
  }

  void _touchEverything() {
    final newName = TextFormInput.dirty(state.name.value);

    state = state.copyWith(
      name: newName,
      isFormValid: Formz.validate([newName]),
    );
  }

  void onNameChanged(String value) {
    state = state.copyWith(
      name: TextFormInput.dirty(value),
      isFormValid: Formz.validate([TextFormInput.dirty(value)]),
    );
  }

  void onSelectTypeChanged(String value) {
    state = state.copyWith(type: value);
  }
}

class StoreFormState {
  final bool isLoading;
  final bool isFormValid;
  final String country;
  final TextFormInput name;
  final String type;
  StoreFormState({
    this.isLoading = false,
    this.isFormValid = false,
    this.country = '',
    this.name = const TextFormInput.pure(),
    this.type = '1',
  });

  StoreFormState copyWith({
    bool? isLoading,
    bool? isFormValid,
    String? country,
    TextFormInput? name,
    String? type,
  }) => StoreFormState(
    isLoading: isLoading ?? this.isLoading,
    isFormValid: isFormValid ?? this.isFormValid,
    country: country ?? this.country,
    name: name ?? this.name,
    type: type ?? this.type,
  );
}
