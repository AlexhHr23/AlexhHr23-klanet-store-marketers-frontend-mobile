import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/products/domain/entities/entities.dart';


// final categoriesCountryProvider = StateNotifierProvider.autoDispose<CategoriesNotifier, CategoriestState>((ref) {

//   final 
//   return ();
// });


// class  CategoriesNotifier extends StateNotifier<CategoriestState> {
//   categoriesNotifier(): super(CategoriestState());
  
// }

class CategoriestState {
  final bool isLoading;
  final List<CategoryProduct> categories;
  final String errorMessage;

  CategoriestState({
    this.isLoading = false, 
    this.categories = const [], 
    this.errorMessage = ''
  });

  CategoriestState copyWith({
    bool? isLoading,
    List<CategoryProduct>? categories,
    String? errorMessage
  }) => CategoriestState(
    isLoading: isLoading ?? this.isLoading,
    categories: categories ?? this.categories,
    errorMessage: errorMessage ?? this.errorMessage
  );
}