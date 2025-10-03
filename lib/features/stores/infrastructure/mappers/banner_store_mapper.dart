import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';

class BannerStoreMapper {
  static BannerStore jsonToEntity(Map<String, dynamic> json) => BannerStore(
    activo: json["activo"] ?? '',
    archivoImagen: json["archivo_imagen"] ?? '',
    duracion: json["duracion"] ?? 0,
    estado: json["estado"] ?? '',
    fechaCreacion: json["fecha_creacion"] != null
        ? DateTime.parse(json["fecha_creacion"])
        : DateTime.now(),
    fechaFin: json["fecha_fin"] != null
        ? DateTime.parse(json["fecha_fin"])
        : DateTime.now(),
    fechaInicio: json["fecha_inicio"] != null
        ? DateTime.parse(json["fecha_inicio"])
        : DateTime.now(),
    fechaModificacion: json["fecha_modificacion"] != null
        ? DateTime.parse(json["fecha_modificacion"])
        : DateTime.now(),
    id: json["id"],
    idTienda: json["id_tienda"],
    idUsuario: json["id_usuario"],
    orden: json["orden"],
    texto: json["texto"],
    url: json["url"],
  );
}
