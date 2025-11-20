import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/products/domain/domain.dart';
import 'package:klanetmarketers/features/products/presentation/providers/products_repository_provider.dart';
import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';

final productsCategoryProvider = StateNotifierProvider.autoDispose
    .family<
      ProductsCategoryNotifier,
      ProductsCategorytState,
      ({String country, int categoryId})
    >((ref, params) {
      final productsRepository = ref.watch(productsRepositoryProvider);
      return ProductsCategoryNotifier(
        productsRepository: productsRepository,
        country: params.country,
        categoryId: params.categoryId,
      );
    });

class ProductsCategoryNotifier extends StateNotifier<ProductsCategorytState> {
  final ProductsRepository productsRepository;
  final String country;
  final int categoryId;
  ProductsCategoryNotifier({
    required this.productsRepository,
    required this.country,
    required this.categoryId,
  }) : super(ProductsCategorytState(country: country, categoryId: categoryId)) {
    getProductsByCategory(country, categoryId);
  }

  Future<void> getProductsByCategory(String country, int categoryId) async {
    state = state.copyWith(isLoading: true);
    try {
      final products = await productsRepository.getProductsByCategory(
        country,
        categoryId,
      );
      state = state.copyWith(link: products.link);
      state = state.copyWith(products: products.products, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<bool> addProductToFavorite(int productId) async {
    try {
      // state = state.copyWith(isLoading: true);
      final status = await productsRepository.addProductToFavorite(
        state.country,
        productId,
      );

      if (status == 'success') {
        // state = state.copyWith(isLoading: false);
        getProductsByCategory(country, categoryId);
        return true;
      } else {
        // state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

class ProductsCategorytState {
  final String country;
  final int categoryId;
  final bool isLoading;
  final String link;
  final List<Producto> products;
  final String errorMessage;

  ProductsCategorytState({
    required this.country,
    required this.categoryId,
    this.isLoading = false,
    this.link = '',
    this.products = const [],
    this.errorMessage = '',
  });

  ProductsCategorytState copyWith({
    String? country,
    int? categoryId,
    bool? isLoading,
    String? link,
    List<Producto>? products,
    String? errorMessage,
  }) => ProductsCategorytState(
    country: country ?? this.country,
    categoryId: categoryId ?? this.categoryId,
    isLoading: isLoading ?? this.isLoading,
    link: link ?? this.link,
    products: products ?? this.products,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
