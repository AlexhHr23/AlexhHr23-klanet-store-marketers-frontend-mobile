import 'package:klanetmarketers/features/products/domain/entities/entities.dart';

abstract class ProductsDatasource {
  Future<List<CategoryProduct>> getCategoriesByCountry(String country);
  Future<ListProducts> getProductsByCategory(String country, int categoryId);
  Future<String> addProductToFavorite(String country, int productId);
}
