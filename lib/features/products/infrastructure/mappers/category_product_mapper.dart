import 'package:klanetmarketers/features/products/domain/domain.dart';

class CategoryProductMapper {
  static CategoryProduct jsonToEntity(Map<String, dynamic> json) =>
      CategoryProduct(
        id: json["id"],
        imagen: json["imagen"],
        nombre: json["nombre"],
      );
}
