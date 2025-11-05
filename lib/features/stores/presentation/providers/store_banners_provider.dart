import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/stores/domain/domain.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider_repository.dart';
import 'package:uuid/uuid.dart';

final bannersStoreProvider = StateNotifierProvider.autoDispose.family<StoreBannersNotifier, StoreBannersState ,(String country, int storeId) >((ref, params) {
   final (country, storeId) = params;

   final storeRepository = ref.watch(storeRepositoryProvider);

  return StoreBannersNotifier(storesRepository: storeRepository, country: country, storeId: storeId);
});

class StoreBannersNotifier extends StateNotifier<StoreBannersState> {
  final StoresRepository storesRepository;
  final String country;
  final int storeId;
  StoreBannersNotifier({
    required this.storesRepository,
    required this.country,
    required this.storeId
  }): super(StoreBannersState(
    country: country,
    storeId: storeId
  )){
    getBannerByStore(country, storeId);
  }


  BannerStore newEmptyBanner() {
    return BannerStore(
      activo: '0', 
      archivoImagen: '', 
      archivoImagenMovil: '', 
      duracion: 0, 
      estado: '', 
      fechaCreacion: DateTime.now(), 
      fechaFin: DateTime.now(), 
      fechaInicio: DateTime.now(), 
      fechaModificacion: DateTime.now(), 
      id: 0, 
      idTienda: state.storeId, 
      idUsuario: '', 
      orden: 0, 
      texto: '', 
      url: ''
    );
  }

  void selectBanner(BannerStore? banner) {
    final newBanner = (banner == null) ? newEmptyBanner() : banner;
    state = state.copyWith(selectedBanner: newBanner);
  }

   Future<bool> createUpdateBanners(
    Map<String, dynamic> bannerLike,
    String country,
  ) async {
    try {
      final banner = await storesRepository.createUpdateBanner(
        bannerLike,
        country,
        storeId.toString()
      );
      final isStoreList = state.banners.any((element) => element.id == banner.id);

      if (!isStoreList) {
        getBannerByStore(state.country, state.storeId);
        return true;
      }

      state = state.copyWith(
        banners: state.banners
            .map((element) => (element.id == banner.id) ? banner : element)
            .toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getBannerByStore(String country, int storeId ) async{
    state = state.copyWith(isLoading: true);

    try {
      final bannersStore = await storesRepository.getBannersByStore(state.country, state.storeId);
      state = state.copyWith(isLoading: false, banners: bannersStore);
    }catch(e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

class StoreBannersState {
  final int storeId;
  final String country;
  final bool isLoading;
  final List<BannerStore> banners;
  BannerStore? selectedBanner;

  StoreBannersState({required this.storeId, required this.country,this.isLoading = false, this.banners = const [], this.selectedBanner });

  StoreBannersState copyWith({
    int? storeId,
    String? country,
    bool? isLoading,
    List<BannerStore>? banners,
    BannerStore? selectedBanner
  }) {
    return StoreBannersState(
      storeId: storeId ?? this.storeId,
      country: country ?? this.country,
      isLoading: isLoading ?? this.isLoading,
      banners: banners ?? this.banners,
      selectedBanner: selectedBanner ?? this.selectedBanner
    );
  }
}