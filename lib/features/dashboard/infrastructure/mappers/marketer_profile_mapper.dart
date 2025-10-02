import '../../domain/entities/entities.dart';

class MarketerProfileMapper {
  static MarketerProfile jsonToEntity(Map<String, dynamic> json) =>
      MarketerProfile(
        marketer: MarketerMapper.jsonToEntity(json["marketer"]),
        sponsor: MarketerMapper.jsonToEntity(json["sponsor"]),
        totalIzq: json["total_izq"] ?? 0,
        totalDer: json["total_der"] ?? 0,
        activosIzq: json["activos_izq"] ?? 0,
        activosDer: json["activos_der"] ?? 0,
        sponsorActivosIzq: json["sponsor_activos_izq"] ?? 0,
        sopnsorActivosDer: json["sopnsor_activos_der"] ?? 0,
        faltantesIzq: json["faltantes_izq"] ?? 0,
        faltantesDer: json["faltantes_der"] ?? 0,
        rangoActual: json["rango_actual"] != null
          ? RangoMapper.jsonToEntity(json["rango_actual"])
          : Rango.empty(),
      rangoSiguiente: json["rango_siguiente"] != null
          ? RangoMapper.jsonToEntity(json["rango_siguiente"])
          : Rango.empty(),
      rangoAnterior: json["rango_anterior"] != null
          ? RangoMapper.jsonToEntity(json["rango_anterior"])
          : Rango.empty(),
      rangoMaximo: json["rango_maximo"] != null
          ? RangoMapper.jsonToEntity(json["rango_maximo"])
          : Rango.empty(),
        tieneGratuidad: json["tiene_gratuidad"] ?? false,
        membresiaActiva: json["membresia_activa"] ?? false,
        puedeComisionarRangos: json["puede_comisionar_rangos"] ?? false,
        status: json["status"] ?? '',
      );
}

class MarketerMapper {
  static Marketer jsonToEntity(Map<String, dynamic> json) => Marketer(
    id: json["id"] ?? '',
    username: json["username"] ?? '',
    idSponsor: json["id_sponsor"] ?? '',
    fechaCreacion: DateTime.parse(json["fecha_creacion"] ?? ''),
    fechaBorrado: json["fecha_borrado"] ?? '',
    fechaModificacion: DateTime.parse(json["fecha_modificacion"] ?? ''),
    fechaLineUp: DateTime.parse(json["fecha_line_up"] ?? ''),
    interno: json["interno"] ?? '',
    tokenRegistro: json["token_registro"] ?? '',
    marketer: json["marketer"] ?? '',
    status: json["status"] ?? '',
    personal: PersonalMapper.jsonToEntity(json["Personal"] ?? {}),
  );
}

class PersonalMapper {
  static Personal jsonToEntity(Map<String, dynamic> json) => Personal(
    id: json["id"] ?? 0,
    idUsuario: json["id_usuario"] ?? '',
    nombre: json["nombre"] ?? '',
    apellido1: json["apellido1"] ?? '',
    apellido2: json["apellido2"] ?? '',
    telefono: json["telefono"] ?? '',
    telIso2: json["tel_iso2"] ?? '',
    nacimiento: json["nacimiento"] ?? '',
    sexo: json["sexo"] ?? '',
    fotografia:
        json["fotografia"] ??
        'https://imgs.search.brave.com/I2VN79_s4G0FQstsuhokQyIFicXVHvvhaa1o4zyL3_8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdDQu/ZGVwb3NpdHBob3Rv/cy5jb20vMTQ5NTM4/NTIvMjI3NzIvdi80/NTAvZGVwb3NpdHBo/b3Rvc18yMjc3MjUx/MjAtc3RvY2staWxs/dXN0cmF0aW9uLWlt/YWdlLWF2YWlsYWJs/ZS1pY29uLWZsYXQt/dmVjdG9yLmpwZw',
    documentoIdentidad: json["documento_identidad"] ?? '',
    code: json["code"] ?? '',
    ultimaActualizacion: DateTime.parse(json["ultima_actualizacion"] ?? ''),
    esResidenteUsa: json["es_residente_usa"] ?? '',
  );
}

class RangoMapper {
  static Rango jsonToEntity(Map<String, dynamic> json) => Rango(
    id: json["ID"] ?? 0,
    name: json["Name"] ?? '',
    izq: json["Izq"] ?? 0,
    der: json["Der"] ?? 0,
    izqDir: json["IzqDir"] ?? 0,
    derDir: json["DerDir"] ?? 0,
    monto: json["Monto"] ?? 0,
  );
}
