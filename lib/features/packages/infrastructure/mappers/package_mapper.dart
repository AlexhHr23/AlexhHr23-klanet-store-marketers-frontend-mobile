
import 'package:klanetmarketers/features/packages/domain/entities/entities.dart';
import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';
import 'package:klanetmarketers/features/shared/infrastructure/mappers/mappers.dart';

class PackageMapper {
  static Package jsonToEntity(Map<String, dynamic> json) => Package(
    id: json["id"] ?? 0,
        idMarketer: json["id_marketer"] ?? '',
        nombre: json["nombre"] ?? '',
        pais: json["pais"] ?? '',
        tipo: json["tipo"] ?? '',
        fechaBaja: json["fecha_baja"] != null ? DateTime.parse(json["fecha_baja"]) : DateTime.now(),
        fechaCreacion: json["fecha_creacion"] != null ? DateTime.parse(json["fecha_creacion"]) : DateTime.now(),
        fechaModificacion: json["fecha_modificacion"] != null ?  DateTime.parse(json["fecha_modificacion"]) : DateTime.now(),
        activo: json["activo"] ?? '',
        productos: json["productos"] != null ? List<Producto>.from(json["productos"].map((x) => ProductoMapper.jsonToEntity(x))) : [],
  );
}