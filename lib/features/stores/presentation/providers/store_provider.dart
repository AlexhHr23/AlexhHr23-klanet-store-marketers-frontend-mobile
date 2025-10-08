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

  Future<void> getStores() async {
    final selectedCountry = state.selectedCountry;
    if (selectedCountry == null) return;

    state = state.copyWith(isLoading: true, stores: []);
    try {
      final stores = await storesRepository.getStores(selectedCountry);
      state = state.copyWith(stores: stores, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

class StoreState {
  final String? selectedCountry;
  final List<MarketerStore> stores;
  final bool isLoading;
  final bool hasSearched;

  StoreState({
    this.selectedCountry,
    this.stores = const [],
    this.isLoading = false,
    this.hasSearched = false,
  });

  StoreState copyWith({
    String? selectedCountry,
    List<MarketerStore>? stores,
    bool? isLoading,
    bool? hasSearched,
  }) {
    return StoreState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      stores: stores ?? this.stores,
      isLoading: isLoading ?? this.isLoading,
      hasSearched: hasSearched ?? this.hasSearched,
    );
  }
}
