class Banner {
  int id;
  String idUsuario;
  String archivoImagen;
  String url;
  String texto;
  DateTime fechaInicio;
  DateTime fechaFin;
  int duracion;
  int orden;
  DateTime fechaCreacion;
  DateTime fechaModificacion;
  String activo;

  Banner({
    required this.id,
    required this.idUsuario,
    required this.archivoImagen,
    required this.url,
    required this.texto,
    required this.fechaInicio,
    required this.fechaFin,
    required this.duracion,
    required this.orden,
    required this.fechaCreacion,
    required this.fechaModificacion,
    required this.activo,
  });
}
