

import 'package:klanetmarketers/features/products/domain/entities/entities.dart';

abstract class ProductsRepository {
  Future<List<CategoryProduct>> getCategoriesByCountry(String country);
}