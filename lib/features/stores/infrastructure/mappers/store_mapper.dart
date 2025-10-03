

import 'package:klanetmarketers/features/dashboard/infrastructure/infrastructure.dart';
import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';
import 'package:klanetmarketers/features/stores/infrastructure/mappers/banner_store_mapper.dart';

class StoreMapper {
  static MarketerStore jsonToEntity(Map<String, dynamic> json) => MarketerStore(
        banners: json["Banners"] != null
            ? List<BannerStore>.from(
                json["Banners"].map((x) => BannerStoreMapper.jsonToEntity(x)))
            : [],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        id: json["id"],
        idUsuario: json["id_usuario"],
        moneda: json["moneda"] ?? '',
        msClarity: json["ms_clarity"],
        nombre: json["nombre"],
        pais: json["pais"],
        slug: json["slug"],
  );
}