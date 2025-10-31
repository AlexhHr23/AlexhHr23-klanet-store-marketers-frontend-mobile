class BannerStore {
    String activo;
    String archivoImagen;
    String archivoImagenMovil;
    int duracion;
    String estado;
    DateTime fechaCreacion;
    DateTime fechaFin;
    DateTime fechaInicio;
    DateTime fechaModificacion;
    int id;
    int idTienda;
    String idUsuario;
    int orden;
    String texto;
    String url;

    BannerStore({
        required this.activo,
        required this.archivoImagen,
        required this.archivoImagenMovil,
        required this.duracion,
        required this.estado,
        required this.fechaCreacion,
        required this.fechaFin,
        required this.fechaInicio,
        required this.fechaModificacion,
        required this.id,
        required this.idTienda,
        required this.idUsuario,
        required this.orden,
        required this.texto,
        required this.url,
    });

}