import 'package:klanetmarketers/features/dashboard/domain/entities/entities.dart';

class BannerMapper {
  static Banner jsonToEntity(Map<String, dynamic> json) => Banner(
    id: json["id"] ?? 0,
    idUsuario: json["id_usuario"] ?? '',
    archivoImagen: json["archivo_imagen"] ?? '',
    url: json["url"] ?? '',
    texto: json["texto"] ?? '',
    fechaInicio: json["fecha_inicio"] != null
        ? DateTime.parse(json["fecha_inicio"])
        : DateTime.now(),
    fechaFin: json["fecha_fin"] != null
        ? DateTime.parse(json["fecha_fin"])
        : DateTime.now(),
    duracion: json["duracion"] ?? 0,
    orden: json["orden"] ?? 0,
    fechaCreacion: json["fecha_creacion"] != null
        ? DateTime.parse(json["fecha_creacion"])
        : DateTime.now(),
    fechaModificacion: json["fecha_modificacion"] != null
        ? DateTime.parse(json["fecha_modificacion"])
        : DateTime.now(),
    activo: json["activo"] ?? '',
  );
}
