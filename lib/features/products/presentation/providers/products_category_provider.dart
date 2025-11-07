import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/products/domain/domain.dart';
import 'package:klanetmarketers/features/products/presentation/providers/products_repository_provider.dart';

final productsCategoryProvider = StateNotifierProvider.autoDispose
    .family<CategoriesNotifier, CategoriestState, String>((ref, country) {
      final productsRepository = ref.watch(productsRepositoryProvider);
      return CategoriesNotifier(
        productsRepository: productsRepository,
        country: country,
      );
    });

class CategoriesNotifier extends StateNotifier<CategoriestState> {
  final ProductsRepository productsRepository;
  final String country;
  CategoriesNotifier({required this.productsRepository, required this.country})
    : super(CategoriestState(country: country)) {
    getCategoriesByCountry(country);
  }

  Future<void> getCategoriesByCountry(String country) async {
    state = state.copyWith(isLoading: true);
    try {
      final categories = await productsRepository.getCategoriesByCountry(
        country,
      );
      state = state.copyWith(categories: categories, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }
}

class CategoriestState {
  final String country;
  final bool isLoading;
  final List<CategoryProduct> categories;
  final String errorMessage;

  CategoriestState({
    required this.country,
    this.isLoading = false,
    this.categories = const [],
    this.errorMessage = '',
  });

  CategoriestState copyWith({
    String? country,
    bool? isLoading,
    List<CategoryProduct>? categories,
    String? errorMessage,
  }) => CategoriestState(
    country: country ?? this.country,
    isLoading: isLoading ?? this.isLoading,
    categories: categories ?? this.categories,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
