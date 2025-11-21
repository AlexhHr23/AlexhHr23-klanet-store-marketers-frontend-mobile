import 'package:klanetmarketers/features/products/domain/domain.dart';
import 'package:klanetmarketers/features/products/infrastructure/datasources/products_datasources_imp.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDatasourcesImp datasource;

  ProductsRepositoryImpl(this.datasource);
  @override
  Future<List<CategoryProduct>> getCategoriesByCountry(String country) {
    return datasource.getCategoriesByCountry(country);
  }

  @override
  Future<ListProducts> getProductsByCategory(String country, int categoryId) {
    return datasource.getProductsByCategory(country, categoryId);
  }

  @override
  Future<String> addProductToFavorite(String country, int productId) {
    return datasource.addProductToFavorite(country, productId);
  }

  @override
  Future<String> deleteProductFromFavorite(String country, int productId) {
    return datasource.deleteProductFromFavorite(country, productId);
  }
  
  @override
  Future<String> addProductToStore(String country, int productId, int storeId) {
   return datasource.addProductToStore(country, productId, storeId);
  }
}
