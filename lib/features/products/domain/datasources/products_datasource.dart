

import 'package:klanetmarketers/features/products/domain/entities/entities.dart';

abstract class ProductsDatasource {
  Future<List<CategoryProduct>> getCategoriesByCountry(String country);
}