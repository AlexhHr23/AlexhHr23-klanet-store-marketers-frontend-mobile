import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/stores/domain/domain.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider_repository.dart';

final storeProvider =
    StateNotifierProvider.autoDispose<StoreNotifier, StoreState>((ref) {
      final storeRepository = ref.watch(storeRepositoryProvider);
      return StoreNotifier(storesRepository: storeRepository);
    });

class StoreNotifier extends StateNotifier<StoreState> {
  final StoresRepository storesRepository;
  StoreNotifier({required this.storesRepository}) : super(StoreState());

  MarketerStore newEmptyStore() {
    return MarketerStore(
      banners: [],
      codigo: '',
      descripcion: '',
      id: 0,
      idUsuario: '',
      moneda: 'MXN',
      msClarity: '',
      nombre: '',
      pais: 'mx',
      slug: '',
    );
  }

  void selectCountry(String countryId) {
    state = state.copyWith(selectedCountry: countryId);
  }

  void selectCurrency(String currency) {
    state = state.copyWith(selectCurrecy: currency);
  }

  void selectStore(MarketerStore? store, int id) {
    final newStore = (store == null && id == 0) ? newEmptyStore() : store;
    state = state.copyWith(selectedStore: newStore);
  }

  Future<bool> createUpdateStore(
    Map<String, dynamic> storeLike,
    String country,
  ) async {
    try {
      final store = await storesRepository.createUpdateStore(
        storeLike,
        country,
      );
      final isStoreList = state.stores.any((element) => element.id == store.id);

      if (!isStoreList) {
        this.getStores();
        return true;
      }

      state = state.copyWith(
        stores: state.stores
            .map((element) => (element.id == store.id) ? store : element)
            .toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteStore(int storeId) async {
    final selectCoutry = state.selectedCountry;
    if (selectCoutry == null) return;
    state.copyWith(isLoading: true);
    try {
      await storesRepository.deleteStore(selectCoutry, storeId);
      state.copyWith(isLoading: false);
      await getStores();
    } catch (e) {
      state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> getStores() async {
    final selectedCountry = state.selectedCountry;
    if (selectedCountry == null) return;

    state = state.copyWith(isLoading: true, stores: []);
    try {
      final stores = await storesRepository.getStores(selectedCountry);
      state = state.copyWith(
        stores: stores,
        isLoading: false,
        hasSearched: true,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> getStoresByCountry(String country) async {
    state = state.copyWith(isLoading: true, stores: []);
    try {
      final stores = await storesRepository.getStores(country);

      if (!mounted) return;

      state = state.copyWith(
        stores: stores,
        isLoading: false,
        hasSearched: true,
      );
    } catch (e) {
      if (!mounted) return;

      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

class StoreState {
  final String errorMessage;
  final String? selectedCountry;
  final String? selectCurrecy;
  final List<MarketerStore> stores;
  final bool isLoading;
  final bool hasSearched;
  final MarketerStore? selectedStore;

  StoreState({
    this.isLoading = false,
    this.hasSearched = false,
    this.errorMessage = '',
    this.selectedCountry,
    this.selectCurrecy,
    this.stores = const [],
    this.selectedStore,
  });

  StoreState copyWith({
    String? selectedCountry,
    String? selectCurrecy,
    String? errorMessage,
    List<MarketerStore>? stores,
    bool? isLoading,
    bool? hasSearched,
    MarketerStore? selectedStore,
  }) {
    return StoreState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectCurrecy: selectCurrecy ?? this.selectCurrecy,
      errorMessage: errorMessage ?? this.errorMessage,
      stores: stores ?? this.stores,
      isLoading: isLoading ?? this.isLoading,
      hasSearched: hasSearched ?? this.hasSearched,
      selectedStore: selectedStore ?? this.selectedStore,
    );
  }
}
