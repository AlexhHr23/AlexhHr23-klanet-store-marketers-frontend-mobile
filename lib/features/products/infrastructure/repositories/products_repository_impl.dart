

import 'package:klanetmarketers/features/products/domain/domain.dart';
import 'package:klanetmarketers/features/products/infrastructure/datasources/products_datasources_imp.dart';

class ProductsRepositoryImpl extends ProductsRepository{

  final ProductsDatasourcesImp datasource;

  ProductsRepositoryImpl(this.datasource, {required String accessToken});
  @override
  Future<List<CategoryProduct>> getCategoriesByCountry(String country) {
    return datasource.getCategoriesByCountry(country) ;
  }

}