import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/providers.dart';
import 'package:klanetmarketers/features/shared/infrastructure/inputs/inputs.dart';
import 'package:klanetmarketers/features/shared/providers/providers.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider.dart';
import '../../domain/entities/store.dart';

final storeFormProvider = StateNotifierProvider.autoDispose
    .family<StoreFormNotifier, StoreFormState, MarketerStore>((ref, store) {
      final createUpdateCallback = ref
          .watch(storeProvider.notifier)
          .createUpdateStore;
      final userId = ref.watch(authProvider).user?.uid ?? '';
      final countryCode =
          ref.watch(storeProvider).selectedCountry ??
          ref.watch(countryProvider).countries.first.id;
      return StoreFormNotifier(
        onSubmitCallback: createUpdateCallback,
        store: store,
        userId: userId,
        countryCode: countryCode,
      );
    });

class StoreFormNotifier extends StateNotifier<StoreFormState> {
  final Future<bool> Function(
    Map<String, dynamic> storeLikem,
    String countryCode,
  )?
  onSubmitCallback;
  final String userid = '';
  final String countryCode = '';

  StoreFormNotifier({
    this.onSubmitCallback,
    required final MarketerStore store,
    required final String userId,
    required final String countryCode,
  }) : super(
         StoreFormState(
           id: store.id,
           currency: store.moneda,
           description: TextFormInput.dirty(store.descripcion),
           userId: userId,
           name: TextFormInput.dirty(store.nombre),
           country: countryCode,
         ),
       );

  Future<bool> onFormSubmit() async {
    _touchEverything();
    if (!state.isFormValid) return false;
    final storeLike = {
      "id": (state.id == 0) ? null : state.id,
      "nombre": state.name.value,
      "id_usuario": state.userId,
      "codigo": state.code,
      "pais": state.country,
      "fb_pixel": "",
      "google_analytics": "",
      "ms_clarity": "",
      "moneda": state.currency,
      "descripcion": state.description.value,
    };

    try {
      // print(storeLike);
      return await onSubmitCallback!(storeLike, state.country);
    } catch (e) {
      // print('error: $e');
      return false;
    }
  }

  void _touchEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        TextFormInput.dirty(state.name.value),
        TextFormInput.dirty(state.description.value),
      ]),
    );
  }

  void onNameChanged(String value) {
    state = state.copyWith(
      name: TextFormInput.dirty(value),
      isFormValid: Formz.validate([
        TextFormInput.dirty(value),
        TextFormInput.dirty(state.description.value),
      ]),
    );
  }

  void onDescChanged(String value) {
    state = state.copyWith(
      description: TextFormInput.dirty(value),
      isFormValid: Formz.validate([
        TextFormInput.dirty(state.name.value),
        TextFormInput.dirty(value),
      ]),
    );
  }

  void onSelectCurrencyChanged(String value) {
    state = state.copyWith(currency: value);
  }
}

class StoreFormState {
  final bool isLoading;
  final bool isFormValid;
  final int id;
  final TextFormInput name;
  final TextFormInput description;
  final String userId;
  final String code;
  final String currency;
  final String country;

  StoreFormState({
    this.isLoading = false,
    this.isFormValid = false,
    this.id = 0,
    this.name = const TextFormInput.pure(),
    this.description = const TextFormInput.pure(),
    this.userId = '',
    this.code = '',
    this.currency = '',
    this.country = '',
  });

  StoreFormState copyWith({
    bool? isLoading,
    bool? isFormValid,
    int? id,
    TextFormInput? name,
    TextFormInput? description,
    String? userId,
    String? code,
    String? currency,
    String? country,
  }) => StoreFormState(
    isLoading: isLoading ?? this.isLoading,
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    userId: userId ?? this.userId,
    code: code ?? this.code,
    currency: currency ?? this.currency,
    country: country ?? this.country,
  );
}
