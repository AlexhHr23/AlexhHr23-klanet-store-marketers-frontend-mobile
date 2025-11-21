import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/stores/domain/domain.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider_repository.dart';

final getStoreProvider = StateNotifierProvider.autoDispose
    .family<StoreNotifier, StoreState, String>((ref, country) {
      final storeRepository = ref.watch(storeRepositoryProvider);
      return StoreNotifier(storesRepository: storeRepository, country: country);
    });

class StoreNotifier extends StateNotifier<StoreState> {
  final StoresRepository storesRepository;
  final String country;

  StoreNotifier({required this.storesRepository, required this.country})
    : super(StoreState(country: country)) {
    getStores();
  }

  Future<void> getStores() async {
    state = state.copyWith(isLoading: true, stores: []);
    try {
      final stores = await storesRepository.getStores(country);
      state = state.copyWith(stores: stores, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

class StoreState {
  final String country;
  final List<MarketerStore> stores;
  final bool isLoading;

  StoreState({
    required this.country,
    this.isLoading = false,
    this.stores = const [],
  });

  StoreState copyWith({List<MarketerStore>? stores, bool? isLoading}) {
    return StoreState(
      country: country,
      stores: stores ?? this.stores,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
