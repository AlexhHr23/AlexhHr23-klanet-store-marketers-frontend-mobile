import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/stores/domain/domain.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider_repository.dart';

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

  StoreBannersState({required this.storeId, required this.country,this.isLoading = false, this.banners = const []});

  get createUpdateStore => null;

  StoreBannersState copyWith({
    int? storeId,
    String? country,
    bool? isLoading,
    List<BannerStore>? banners
  }) {
    return StoreBannersState(
      storeId: storeId ?? this.storeId,
      country: country ?? this.country,
      isLoading: isLoading ?? this.isLoading,
      banners: banners ?? this.banners
    );
  }
}