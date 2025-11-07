import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/stores/domain/domain.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider_repository.dart';

final productsStoreProvider = StateNotifierProvider.autoDispose.family<StoreBannersNotifier, StoreBannersState ,(String country, int storeId) >((ref, params) {
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
    getProductsByStore(country, storeId);
  }

  Future<void> getProductsByStore(String country, int storeId ) async{
    state = state.copyWith(isLoading: true);
    try {
      final products = await storesRepository.getProductsByStore(state.country, state.storeId);

      if(!mounted) return;

      state = state.copyWith(isLoading: false, products: products);
    }catch(e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
  
  Future<bool> deleteProductByStore(String country, int productId) async{
    try {
      final status = await storesRepository.deleteProductByStore(country, productId);
     if(!mounted) return false;

      if(status == 'success'){
        final updatedList = state.products.where((p) => p.id != productId).toList();
        state = state.copyWith(isLoading: false, products: updatedList);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

class StoreBannersState {
  final int storeId;
  final String country;
  final bool isLoading;
  final List<ProductoStore> products;
  BannerStore? selectedBanner;

  StoreBannersState({required this.storeId, required this.country,this.isLoading = false, this.products = const [], this.selectedBanner });

  StoreBannersState copyWith({
    int? storeId,
    String? country,
    bool? isLoading,
    List<ProductoStore>? products,

  }) {
    return StoreBannersState(
      storeId: storeId ?? this.storeId,
      country: country ?? this.country,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }
}