import 'package:klanetmarketers/features/products/domain/entities/entities.dart';

abstract class ProductsDatasource {
  Future<List<CategoryProduct>> getCategoriesByCountry(String country);
  Future<ListProducts> getProductsByCategory(String country, int categoryId);
  Future<String> addProductToFavorite(String country, int productId);
  Future<String> deleteProductFromFavorite(String country, int productId);
  Future<String> addProductToStore(String country, int productId, int storeId);
  Future<String> addProductToPackage(
    String country,
    int productId,
    int packageId,
  );
}
