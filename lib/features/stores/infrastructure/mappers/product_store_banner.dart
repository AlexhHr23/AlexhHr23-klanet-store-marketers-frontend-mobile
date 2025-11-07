import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';
import '../../../shared/infrastructure/mappers/mappers.dart';

class ProductStoreMapper {
  static ProductoStore jsonToEntity(Map<String, dynamic> json) => ProductoStore(
    producto: ProductoMapper.jsonToEntity(json["Producto"]),
    id: json["id"] ?? 0,
    idProducto: json["id_producto"] ?? 0,
    idTienda: json["id_tienda"] ?? 0,
  );
}

