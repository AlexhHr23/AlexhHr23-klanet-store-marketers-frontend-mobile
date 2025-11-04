import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:klanetmarketers/features/shared/infrastructure/inputs/inputs.dart';
import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_banners_provider.dart';

final bannerFormProvider = StateNotifierProvider.autoDispose
    .family<
      StoreFormNotifier,
      StoreFormState,
      ({BannerStore banner, String country, int storeId})
    >((ref, params) {
      final repo = ref.watch(
        bannersStoreProvider((params.country, params.storeId)),
      );
      final createUpdateCallback = repo.createUpdateStore;

      return StoreFormNotifier(
        onSubmitCallback: createUpdateCallback,
        banner: params.banner,
        countryCode: params.country,
        storeId: params.storeId.toString(),
      );
    });

class StoreFormNotifier extends StateNotifier<StoreFormState> {
  final Future<bool> Function(Map<String, dynamic> storeLike)? onSubmitCallback;
  final String countryCode;
  final String storeId;

  StoreFormNotifier({
    this.onSubmitCallback,
    required final BannerStore banner,
    required this.countryCode,
    required this.storeId,
  }) : super(
         StoreFormState(
           id: banner.id,
           fileImage: TextFormInput.dirty(banner.archivoImagen),
           fileImageMobile: TextFormInput.dirty(banner.archivoImagenMovil),
           duration: NumInput.dirty(banner.duracion),
           state: banner.estado,
           storeId: int.parse(storeId),
           order: NumInput.dirty(banner.orden),
           text: TextFormInput.dirty(banner.texto),
         ),
       );

  Future<bool> onFormSubmit() async {
    _touchEverything();
    if (!state.isFormValid) return false;
    final bannerLike = {
      "id": (state.id == 0) ? null : state.id,
      "id_tienda": storeId,
      "texto": state.text,
      "url": '',
      "orden": state.order,
      "duracion": state.duration,
      "estado": state.state,
      "archivo_imagen": state.fileImage,
      "archivo_imagen_movil": state.fileImageMobile,
    };

    try {
      print(bannerLike);
      return await onSubmitCallback!(bannerLike);
    } catch (e) {
      print('error: $e');
      return false;
    }
  }

  void _touchEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        TextFormInput.dirty(state.fileImage.value),
        TextFormInput.dirty(state.fileImageMobile.value),
        TextFormInput.dirty(state.text.value),
      ]),
    );
  }

  void onSelectBannerChanged(String value) {
    state = state.copyWith(
      fileImage: TextFormInput.dirty(value),
      isFormValid: Formz.validate([
        TextFormInput.dirty(value),
        TextFormInput.dirty(state.fileImageMobile.value),
        TextFormInput.dirty(state.text.value),
        NumInput.dirty(state.duration.value),
        NumInput.dirty(state.order.value),
      ]),
    );
  }

  void onSelectBannerMobileChanged(String value) {
    state = state.copyWith(
      fileImageMobile: TextFormInput.dirty(value),
      isFormValid: Formz.validate([
        TextFormInput.dirty(state.fileImage.value),
        TextFormInput.dirty(value),
        TextFormInput.dirty(state.text.value),
        NumInput.dirty(state.duration.value),
        NumInput.dirty(state.order.value),
      ]),
    );
  }

   void onTitleChanged(String value) {
    state = state.copyWith(
      text: TextFormInput.dirty(value),
      isFormValid: Formz.validate([
        TextFormInput.dirty(value),
        TextFormInput.dirty(state.fileImage.value),
        TextFormInput.dirty(state.fileImageMobile.value),
      ]),
    );
  }

  void onDurationChanged(int value) {
    state = state.copyWith(
      duration: NumInput.dirty(value),
      isFormValid: Formz.validate([
        TextFormInput.dirty(state.fileImage.value),
        TextFormInput.dirty(state.fileImageMobile.value),
        TextFormInput.dirty(state.text.value),
        NumInput.dirty(value),
        NumInput.dirty(state.order.value),
      ]),
    );
  }

  void onOrderChanged(int value) {
    state = state.copyWith(
      order: NumInput.dirty(value),
      isFormValid: Formz.validate([
        TextFormInput.dirty(state.fileImage.value),
        TextFormInput.dirty(state.fileImageMobile.value),
        TextFormInput.dirty(state.text.value),
        NumInput.dirty(state.duration.value),
        NumInput.dirty(value),
      ]),
    );
  }
}

class StoreFormState {
  final bool isLoading;
  final bool isFormValid;
  final int id;
  final TextFormInput fileImage;
  final TextFormInput fileImageMobile;
  final NumInput duration;
  final String state;
  final int storeId;
  final NumInput order;
  final TextFormInput text;

  StoreFormState({
    this.isLoading = false,
    this.isFormValid = false,
    this.id = 0,
    this.fileImage = const TextFormInput.pure(),
    this.fileImageMobile = const TextFormInput.pure(),
    this.duration = const NumInput.dirty(),
    this.state = '',
    this.storeId = 0,
    this.order = const NumInput.dirty(),
    this.text = const TextFormInput.pure(),
  });

  StoreFormState copyWith({
    bool? isLoading,
    bool? isFormValid,
    int? id,
    TextFormInput? fileImage,
    TextFormInput? fileImageMobile,
    NumInput? duration,
    String? state,
    int? storeId,
    NumInput? order,
    TextFormInput? text,
  }) => StoreFormState(
    isLoading: isLoading ?? this.isLoading,
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    fileImage: fileImage ?? this.fileImage,
    fileImageMobile: fileImageMobile ?? this.fileImageMobile,
    duration: duration ?? this.duration,
    state: state ?? this.state,
    storeId: storeId ?? this.storeId,
    order: order ?? this.order,
    text: text ?? this.text,
  );
}
