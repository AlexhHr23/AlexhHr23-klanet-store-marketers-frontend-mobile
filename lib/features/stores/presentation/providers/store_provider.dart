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

  void selectCountry(String countryId) {
    state = state.copyWith(selectedCountry: countryId);
  }

  void selectCurrency(String currency) {
    state = state.copyWith(selectCurrecy: currency);
  }

  void selectStore(MarketerStore store) {
    state = state.copyWith(selectedStore: store);
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
}

class StoreState {
  final String? selectedCountry;
  final String? selectCurrecy;
  final List<MarketerStore> stores;
  final bool isLoading;
  final bool hasSearched;
  final MarketerStore? selectedStore;

  StoreState({
    this.isLoading = false,
    this.hasSearched = false,
    this.selectedCountry,
    this.selectCurrecy,
    this.stores = const [],
    this.selectedStore,
  });

  StoreState copyWith({
    String? selectedCountry,
    String? selectCurrecy,
    List<MarketerStore>? stores,
    bool? isLoading,
    bool? hasSearched,
    MarketerStore? selectedStore,
  }) {
    return StoreState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectCurrecy: selectCurrecy ?? this.selectCurrecy,
      stores: stores ?? this.stores,
      isLoading: isLoading ?? this.isLoading,
      hasSearched: hasSearched ?? this.hasSearched,
      selectedStore: selectedStore ?? this.selectedStore,
    );
  }
}
