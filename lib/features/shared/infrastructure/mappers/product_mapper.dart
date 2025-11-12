import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';

class ProductoMapper {
  static Producto jsonToEntity(Map<String, dynamic> json) => Producto(
    fotos: List<Foto>.from(
      json["Fotos"].map((x) => PhotoMapper.jsonToEntity(x)),
    ),
    padre: PadreMapper.jsonToEntity(json["Padre"]),
    precioAntesImpuesto: json["PrecioAntesImpuesto"]?.toDouble() ?? 0.0,
    precioDescuentoAntesImpuesto:
        json["PrecioDescuentoAntesImpuesto"]?.toDouble() ?? 0.0,
    activo: json["activo"] ?? '',
    atributos: json["atributos"] ?? '',
    cantidadMinima: json["cantidad_minima"] ?? 0,
    clave: json["clave"] ?? '',
    codigobarras: json["codigobarras"] ?? '',
    comisionPorcentaje: json["comision_porcentaje"]?.toDouble() ?? 0.0,
    costoEnvio: json["costo_envio"] ?? 0.0,
    descripcionLarga: json["descripcion_larga"] ?? '',
    diasEntrega: json["dias_entrega"] ?? 0,
    envioIncluido: json["envio_incluido"] ?? '',
    envioSolitario: json["envio_solitario"] ?? '',
    esFavorito: json["es_favorito"] ?? '',
    esInventariable: json["es_inventariable"] ?? '',
    existencia: json["existencia"] ?? 0,
    fechaBaja: DateTime.parse(json["fecha_baja"]),
    fechaCreacion: DateTime.parse(json["fecha_creacion"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    habilitado: json["habilitado"] ?? '',
    id: json["id"] ?? 0,
    idEmpresa: json["id_empresa"] ?? 0,
    idPadre: json["id_padre"] ?? 0,
    idUsuario: json["id_usuario"] ?? 0,
    idVarianteShopify: json["id_variante_shopify"] ?? '',
    impuesto: json["impuesto"]?.toDouble() ?? 0.0,
    modelo: json["modelo"] ?? '',
    moneda: json["moneda"] ?? '',
    precioDescuento: json["precio_descuento"]?.toDouble(),
    precioEnvio: json["precio_envio"]?.toDouble() ?? 0.0,
    precioUnitario: json["precio_unitario"]?.toDouble() ?? 0.0,
    rating: json["rating"]?.toDouble() ?? 0.0,
    sku: json["sku"] ?? '',
    slug: json["slug"] ?? '',
    tags: json["tags"] ?? '',
    varianteComb: json["variante_comb"] ?? '',
    variantePrincipal: json["variante_principal"] ?? '',
    venderSinExistencia: json["vender_sin_existencia"] ?? '',
  );
}

class PhotoMapper {
  static Foto jsonToEntity(Map<String, dynamic> json) => Foto(
    activo: json["activo"] ?? '',
    archivo: json["archivo"] ?? '',
    descripcion: json["descripcion"] ?? '',
    fechaAlta: DateTime.parse(json["fecha_alta"]),
    fechaBaja: DateTime.parse(json["fecha_baja"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    id: json["id"] ?? 0,
    idProducto: json["id_producto"] ?? 0,
    orden: json["orden"] ?? 0,
    titulo: json["titulo"] ?? '',
  );
}

class PadreMapper {
  static Padre jsonToEntity(Map<String, dynamic> json) => Padre(
    categoria: CategoryMapper.jsonToEntity(json["Categoria"]),
    empresa: EmpresaMapper.jsonToEntity(json["Empresa"]),
    marca: MarcaMapper.jsonToEntity(json["Marca"]),
    tipo: TipoMapper.jsonToEntity(json["Tipo"]),
    activo: json["activo"] ?? '',
    descripcion: json["descripcion"] ?? '',
    destacado: json["destacado"] ?? '',
    envioInternacional: json["envio_internacional"] ?? '',
    fechaCreacion: DateTime.parse(json["fecha_creacion"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    id: json["id"] ?? 0,
    idCategoria: json["id_categoria"] ?? 0,
    idEmpresa: json["id_empresa"] ?? 0,
    idMarca: json["id_marca"] ?? 0,
    idTipo: json["id_tipo"] ?? 0,
    idUsuario: json["id_usuario"] ?? 0,
    mostrarEnPortada: json["mostrar_en_portada"] ?? '',
    nombre: json["nombre"] ?? '',
    paisesEnvio: json["paises_envio"] ?? '',
    tieneDevolucion: json["tiene_devolucion"] ?? '',
    tieneVariantes: json["tiene_variantes"] ?? '',
    variantes: json["variantes"] ?? '',
  );
}

class MarcaMapper {
  static Marca jsonToEntity(Map<String, dynamic> json) => Marca(
    activo: json["activo"] ?? '',
    fechaAlta: DateTime.parse(json["fecha_alta"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    id: json["id"] ?? 0,
    idUsuario: json["id_usuario"] ?? '',
    imagen: json["imagen"] ?? '',
    nombre: json["nombre"] ?? '',
    slug: json["slug"] ?? '',
  );
}

class CategoryMapper {
  static Categoria jsonToEntity(Map<String, dynamic> json) => Categoria(
    activo: json["activo"] ?? '',
    atributos: json["atributos"] ?? '',
    bannerImg: json["banner_img"] ?? '',
    descripcion: json["descripcion"] ?? '',
    fechaCreacion: DateTime.parse(json["fecha_creacion"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    id: json["id"] ?? 0,
    idPadre: json["id_padre"] ?? 0,
    imagen: json["imagen"] ?? '',
    imagenPortada: json["imagen_portada"] ?? '',
    mostrarEnMenu: json["mostrar_en_menu"] ?? '',
    mostrarEnPortada: json["mostrar_en_portada"] ?? '',
    mostrarHome: json["mostrar_home"] ?? '',
    nombre: json["nombre"] ?? '',
    orden: json["orden"] ?? 0,
    slug: json["slug"] ?? '',
    tags: json["tags"] ?? '',
    tipo: json["tipo"] ?? '',
  );
}

class EmpresaMapper {
  static Empresa jsonToEntity(Map<String, dynamic> json) => Empresa(
    clave: json["Clave"] ?? '',
    fullName: json["FullName"] ?? '',
    activo: json["activo"] ?? '',
    descripcion: json["descripcion"] ?? '',
    diasGestion: json["dias_gestion"] ?? 0,
    fechaRegistro: DateTime.parse(json["fecha_registro"]),
    id: json["id"] ?? 0,
    idMarketer: json["id_marketer"] ?? '',
    idUsuario: json["id_usuario"] ?? '',
    ligaFacturacion: json["liga_facturacion"] ?? '',
    logo: json["logo"] ?? '',
    nombre: json["nombre"] ?? '',
    nombreCorto: json["nombre_corto"] ?? '',
  );
}

class TipoMapper {
  static Tipo jsonToEntity(Map<String, dynamic> json) => Tipo(
    activo: json["activo"] ?? '',
    esFisico: json["es_fisico"] ?? '',
    fechaCreacion: json["fecha_creacion"] != null
        ? DateTime.parse(json["fecha_creacion"])
        : DateTime.now(),
    id: json["id"] ?? 0,
    nombre: json["nombre"] ?? '',
  );
}
