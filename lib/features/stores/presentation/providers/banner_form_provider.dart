import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klanetmarketers/features/shared/infrastructure/inputs/inputs.dart';
import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_banners_provider.dart';


final bannerFormProvider = StateNotifierProvider.autoDispose
    .family<
      StoreFormNotifier,
      StoreFormState,
      ({BannerStore banner, String country, int storeId})
    >((ref, params) {

  final createUpdateCallback = ref.watch(bannersStoreProvider((params.country, params.storeId)).notifier).createUpdateBanners;

  return StoreFormNotifier(
    onSubmitCallback: createUpdateCallback,
    banner: params.banner,
    countryCode: params.country,
    storeId: params.storeId.toString(),
  );
});

class StoreFormNotifier extends StateNotifier<StoreFormState> {
  final Future<bool> Function(Map<String, dynamic> storeLike, String country)? onSubmitCallback;
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
            fileImage: null,
            fileImageMobile: null,
            duration: NumInput.dirty(banner.duracion),
            state: banner.estado,
            storeId: int.parse(storeId),
            order: NumInput.dirty(banner.orden),
            text: TextFormInput.dirty(banner.texto),
          ),
        );

  // ======== SUBMIT ==========
  Future<bool> onFormSubmit() async {
    _touchEverything();
    if (!state.isFormValid) return false;

    final bannerLike = {
      "id": (state.id == 0) ? null : state.id,
      "id_tienda": storeId,
      "texto": state.text.value,
      "url": '',
      "orden": state.order.value,
      "duracion": state.duration.value,
      "estado": state.state,
      "archivo_imagen": state.fileImage,
      "archivo_imagen_movil": state.fileImageMobile,
    };

    try {
      print('bannerLike: $bannerLike');
      print('archivo_imagen: ${state.fileImage?.path}');
      print('archivo_imagen_movil: ${state.fileImageMobile?.path}');
      print('countryCode: $countryCode');
      return await onSubmitCallback!(bannerLike, countryCode);
    } catch (e, s) {
      print('error: $e');
      print('stack: $s');
      return false;
    }
  }


  void _touchEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        state.text,
        state.order,
        state.duration,
      ]),
    );
  }

  // ======== CAMBIO DE IMAGEN DESDE PICKER ==========
  void onImageSelected(XFile? pickedFile) {
    if (pickedFile == null) return;
    state = state.copyWith(
      fileImage: pickedFile,
    );
  }

  void onImageMobileSelected(XFile? pickedFile) {
    if (pickedFile == null) return;
    state = state.copyWith(
      fileImageMobile: pickedFile,
    );
  }

  // ======== OTROS CAMPOS ==========
  void onTitleChanged(String value) {
    final textInput = TextFormInput.dirty(value);
    state = state.copyWith(
      text: textInput,
      isFormValid: Formz.validate([
        textInput,
        state.duration,
        state.order,
      ]),
    );
  }

  void onDurationChanged(int value) {
    final durationInput = NumInput.dirty(value);
    state = state.copyWith(
      duration: durationInput,
      isFormValid: Formz.validate([
        state.text,
        durationInput,
        state.order,
      ]),
    );
  }

  void onOrderChanged(int value) {
    final orderInput = NumInput.dirty(value);
    state = state.copyWith(
      order: orderInput,
      isFormValid: Formz.validate([
        state.text,
        state.duration,
        orderInput,
      ]),
    );
  }
}

class StoreFormState {
   final bool isLoading;
  final bool isFormValid;
  final int id;
  final XFile? fileImage;
  final XFile? fileImageMobile;
  final NumInput duration;
  final String state;
  final int storeId;
  final NumInput order;
  final TextFormInput text;

  StoreFormState({
    this.isLoading = false,
    this.isFormValid = false,
    this.id = 0,
    this.fileImage,
    this.fileImageMobile,
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
    XFile? fileImage,
    XFile? fileImageMobile,
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
