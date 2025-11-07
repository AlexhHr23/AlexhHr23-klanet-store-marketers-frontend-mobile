

import 'package:klanetmarketers/features/products/domain/entities/entities.dart';
import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';

abstract class ProductsRepository {
  Future<List<CategoryProduct>> getCategoriesByCountry(String country);
  Future<List<Producto>> getProductsByCategory(String country, int categoryId);
}