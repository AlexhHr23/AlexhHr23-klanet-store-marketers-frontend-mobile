class MarketerProfile {
  final Marketer marketer;
  final Marketer sponsor;
  final int totalIzq;
  final int totalDer;
  final int activosIzq;
  final int activosDer;
  final int sponsorActivosIzq;
  final int sopnsorActivosDer;
  final int faltantesIzq;
  final int faltantesDer;
  final Rango rangoActual;
  final Rango rangoSiguiente;
  final Rango rangoAnterior;
  final Rango rangoMaximo;
  final bool tieneGratuidad;
  final bool membresiaActiva;
  final bool puedeComisionarRangos;
  final String status;

  MarketerProfile({
    required this.marketer,
    required this.sponsor,
    required this.totalIzq,
    required this.totalDer,
    required this.activosIzq,
    required this.activosDer,
    required this.sponsorActivosIzq,
    required this.sopnsorActivosDer,
    required this.faltantesIzq,
    required this.faltantesDer,
    required this.rangoActual,
    required this.rangoSiguiente,
    required this.rangoAnterior,
    required this.rangoMaximo,
    required this.tieneGratuidad,
    required this.membresiaActiva,
    required this.puedeComisionarRangos,
    required this.status,
  });

  factory MarketerProfile.empty() => MarketerProfile(
    marketer: Marketer.empty(),
    sponsor: Marketer.empty(),
    totalIzq: 0,
    totalDer: 0,
    activosIzq: 0,
    activosDer: 0,
    sponsorActivosIzq: 0,
    sopnsorActivosDer: 0,
    faltantesIzq: 0,
    faltantesDer: 0,
    rangoActual: Rango.empty() ,
    rangoSiguiente: Rango.empty(),
    rangoAnterior: Rango.empty(),
    rangoMaximo: Rango.empty(),
    tieneGratuidad: false,
    membresiaActiva: false,
    puedeComisionarRangos: false,
    status: '',
  );
}

class Marketer {
  final String id;
  final String username;
  final String idSponsor;
  final DateTime fechaCreacion;
  final dynamic fechaBorrado;
  final DateTime fechaModificacion;
  final DateTime fechaLineUp;
  final String interno;
  final String tokenRegistro;
  final String marketer;
  final String status;
  final Personal personal;

  Marketer({
    required this.id,
    required this.username,
    required this.idSponsor,
    required this.fechaCreacion,
    required this.fechaBorrado,
    required this.fechaModificacion,
    required this.fechaLineUp,
    required this.interno,
    required this.tokenRegistro,
    required this.marketer,
    required this.status,
    required this.personal,
  });

  factory Marketer.empty() => Marketer(
    id: '',
    username: '',
    idSponsor: '',
    fechaCreacion: DateTime.now(),
    fechaBorrado: null,
    fechaModificacion: DateTime.now(),
    fechaLineUp: DateTime.now(),
    interno: '',
    tokenRegistro: '',
    marketer: '',
    status: '',
    personal: Personal.empty(),
  );
}

class Personal {
  final int id;
  final String idUsuario;
  final String nombre;
  final String apellido1;
  final String apellido2;
  final String telefono;
  final String telIso2;
  final dynamic nacimiento;
  final String sexo;
  final String fotografia;
  final String documentoIdentidad;
  final String code;
  final DateTime ultimaActualizacion;
  final String esResidenteUsa;

  Personal({
    required this.id,
    required this.idUsuario,
    required this.nombre,
    required this.apellido1,
    required this.apellido2,
    required this.telefono,
    required this.telIso2,
    required this.nacimiento,
    required this.sexo,
    required this.fotografia,
    required this.documentoIdentidad,
    required this.code,
    required this.ultimaActualizacion,
    required this.esResidenteUsa,
  });

  factory Personal.empty() => Personal(
    id: 0,
    idUsuario: '',
    nombre: '',
    apellido1: '',
    apellido2: '',
    telefono: '',
    telIso2: '',
    nacimiento: null,
    sexo: '',
    fotografia: '',
    documentoIdentidad: '',
    code: '',
    ultimaActualizacion: DateTime.now(),
    esResidenteUsa: '',
  );
}

class Rango {
  final int id;
  final String name;
  final int izq;
  final int der;
  final int izqDir;
  final int derDir;
  final int monto;

  Rango({
    required this.id,
    required this.name,
    required this.izq,
    required this.der,
    required this.izqDir,
    required this.derDir,
    required this.monto,
  });

  factory Rango.empty() => Rango(
    id: 0,
    name: '',
    izq: 0,
    der: 0,
    izqDir: 0,
    derDir: 0,
    monto: 0,
  );
}
