class ProductoStore {
    Producto producto;
    int id;
    int idProducto;
    int idTienda;

    ProductoStore({
        required this.producto,
        required this.id,
        required this.idProducto,
        required this.idTienda,
    });

}

class Producto {
    List<Foto> fotos;
    Padre padre;
    double precioAntesImpuesto;
    double precioDescuentoAntesImpuesto;
    String activo;
    String atributos;
    int cantidadMinima;
    String clave;
    String codigobarras;
    double comisionPorcentaje;
    int costoEnvio;
    String descripcionLarga;
    int diasEntrega;
    String envioIncluido;
    String envioSolitario;
    int esFavorito;
    String esInventariable;
    int existencia;
    DateTime fechaBaja;
    DateTime fechaCreacion;
    DateTime fechaModificacion;
    String habilitado;
    int id;
    int idEmpresa;
    int idPadre;
    String idUsuario;
    String idVarianteShopify;
    double impuesto;
    String modelo;
    String moneda;
    double precioDescuento;
    double precioEnvio;
    double precioUnitario;
    double rating;
    String sku;
    String slug;
    String tags;
    String varianteComb;
    String variantePrincipal;
    String venderSinExistencia;

    Producto({
        required this.fotos,
        required this.padre,
        required this.precioAntesImpuesto,
        required this.precioDescuentoAntesImpuesto,
        required this.activo,
        required this.atributos,
        required this.cantidadMinima,
        required this.clave,
        required this.codigobarras,
        required this.comisionPorcentaje,
        required this.costoEnvio,
        required this.descripcionLarga,
        required this.diasEntrega,
        required this.envioIncluido,
        required this.envioSolitario,
        required this.esFavorito,
        required this.esInventariable,
        required this.existencia,
        required this.fechaBaja,
        required this.fechaCreacion,
        required this.fechaModificacion,
        required this.habilitado,
        required this.id,
        required this.idEmpresa,
        required this.idPadre,
        required this.idUsuario,
        required this.idVarianteShopify,
        required this.impuesto,
        required this.modelo,
        required this.moneda,
        required this.precioDescuento,
        required this.precioEnvio,
        required this.precioUnitario,
        required this.rating,
        required this.sku,
        required this.slug,
        required this.tags,
        required this.varianteComb,
        required this.variantePrincipal,
        required this.venderSinExistencia,
    });

}

class Foto {
    String activo;
    String archivo;
    String descripcion;
    DateTime fechaAlta;
    DateTime fechaBaja;
    DateTime fechaModificacion;
    int id;
    int idProducto;
    int orden;
    String titulo;

    Foto({
        required this.activo,
        required this.archivo,
        required this.descripcion,
        required this.fechaAlta,
        required this.fechaBaja,
        required this.fechaModificacion,
        required this.id,
        required this.idProducto,
        required this.orden,
        required this.titulo,
    });

}


class Padre {
    Categoria categoria;
    Empresa empresa;
    Marca marca;
    String activo;
    String descripcion;
    String destacado;
    String envioInternacional;
    DateTime fechaCreacion;
    DateTime fechaModificacion;
    int id;
    int idCategoria;
    int idEmpresa;
    int idMarca;
    int idTipo;
    String idUsuario;
    String mostrarEnPortada;
    String nombre;
    String paisesEnvio;
    String tieneDevolucion;
    String tieneVariantes;
    String variantes;

    Padre({
        required this.categoria,
        required this.empresa,
        required this.marca,
        required this.activo,
        required this.descripcion,
        required this.destacado,
        required this.envioInternacional,
        required this.fechaCreacion,
        required this.fechaModificacion,
        required this.id,
        required this.idCategoria,
        required this.idEmpresa,
        required this.idMarca,
        required this.idTipo,
        required this.idUsuario,
        required this.mostrarEnPortada,
        required this.nombre,
        required this.paisesEnvio,
        required this.tieneDevolucion,
        required this.tieneVariantes,
        required this.variantes,
    });

}

class Categoria {
    String activo;
    String atributos;
    String bannerImg;
    String descripcion;
    DateTime fechaCreacion;
    DateTime fechaModificacion;
    int id;
    int idPadre;
    String imagen;
    String imagenPortada;
    String mostrarEnMenu;
    String mostrarEnPortada;
    String mostrarHome;
    String nombre;
    int orden;
    String slug;
    String tags;
    String tipo;

    Categoria({
        required this.activo,
        required this.atributos,
        required this.bannerImg,
        required this.descripcion,
        required this.fechaCreacion,
        required this.fechaModificacion,
        required this.id,
        required this.idPadre,
        required this.imagen,
        required this.imagenPortada,
        required this.mostrarEnMenu,
        required this.mostrarEnPortada,
        required this.mostrarHome,
        required this.nombre,
        required this.orden,
        required this.slug,
        required this.tags,
        required this.tipo,
    });

}



class Empresa {
    String clave;
    String fullName;
    String activo;
    String descripcion;
    int diasGestion;
    DateTime fechaRegistro;
    int id;
    String idMarketer;
    String idUsuario;
    String ligaFacturacion;
    String logo;
    String nombre;
    String nombreCorto;

    Empresa({
        required this.clave,
        required this.fullName,
        required this.activo,
        required this.descripcion,
        required this.diasGestion,
        required this.fechaRegistro,
        required this.id,
        required this.idMarketer,
        required this.idUsuario,
        required this.ligaFacturacion,
        required this.logo,
        required this.nombre,
        required this.nombreCorto,
    });

}

class Marca {
    String activo;
    DateTime fechaAlta;
    DateTime fechaModificacion;
    int id;
    String idUsuario;
    String imagen;
    String nombre;
    String slug;

    Marca({
        required this.activo,
        required this.fechaAlta,
        required this.fechaModificacion,
        required this.id,
        required this.idUsuario,
        required this.imagen,
        required this.nombre,
        required this.slug,
    });

}
