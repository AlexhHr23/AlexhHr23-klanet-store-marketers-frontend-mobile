import 'package:klanetmarketers/features/shared/infrastructure/mappers/mappers.dart';
import '../../../shared/domain/entities/product.dart';
import '../../domain/entities/entities.dart';

class ListProductMapper {
  static ListProducts jsonToEntity(Map<String, dynamic> json) => ListProducts(
    link: json["data"],
    products: json["zdata"] != null
        ? List<Producto>.from(
            json["zdata"].map((x) => ProductoMapper.jsonToEntity(x)),
          )
        : [],
  );
}
