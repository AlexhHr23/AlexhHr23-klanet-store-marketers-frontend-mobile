import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';

class ProductStoreMapper {
  static ProductoStore jsonToEntity(Map<String, dynamic> json) => ProductoStore(
    producto: ProductoMapper.jsonToEntity(json["Producto"]),
    id: json["id"] ?? 0,
    idProducto: json["id_producto"] ?? 0,
    idTienda: json["id_tienda"] ?? 0,
  );
}

class ProductoMapper {
  static Producto jsonToEntity(Map<String, dynamic> json) => Producto(
    fotos: List<Foto>.from(
      json["Fotos"].map((x) => PhotoMapper.jsonToEntity(x)),
    ),
    padre: PadreMapper.jsonToEntity(json["Padre"]),
    precioAntesImpuesto: json["PrecioAntesImpuesto"]?.toDouble() ?? 0.0,
    precioDescuentoAntesImpuesto: json["PrecioDescuentoAntesImpuesto"]?.toDouble() ?? 0.0,
    activo: json["activo"] ,
    atributos: json["atributos"],
    cantidadMinima: json["cantidad_minima"],
    clave: json["clave"],
    codigobarras: json["codigobarras"],
    comisionPorcentaje: json["comision_porcentaje"]?.toDouble(),
    costoEnvio: json["costo_envio"],
    descripcionLarga: json["descripcion_larga"],
    diasEntrega: json["dias_entrega"],
    envioIncluido: json["envio_incluido"],
    envioSolitario: json["envio_solitario"],
    esFavorito: json["es_favorito"],
    esInventariable: json["es_inventariable"],
    existencia: json["existencia"],
    fechaBaja: DateTime.parse(json["fecha_baja"]),
    fechaCreacion: DateTime.parse(json["fecha_creacion"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    habilitado: json["habilitado"],
    id: json["id"],
    idEmpresa: json["id_empresa"],
    idPadre: json["id_padre"],
    idUsuario: json["id_usuario"],
    idVarianteShopify: json["id_variante_shopify"],
    impuesto: json["impuesto"],
    modelo: json["modelo"],
    moneda: json["moneda"],
    precioDescuento: json["precio_descuento"]?.toDouble(),
    precioEnvio: json["precio_envio"],
    precioUnitario: json["precio_unitario"]?.toDouble(),
    rating: json["rating"],
    sku: json["sku"],
    slug: json["slug"],
    tags: json["tags"],
    varianteComb: json["variante_comb"],
    variantePrincipal: json["variante_principal"],
    venderSinExistencia: json["vender_sin_existencia"],
  );
}

class PhotoMapper {
  static Foto jsonToEntity(Map<String, dynamic> json) => Foto(
    activo: json["activo"],
    archivo: json["archivo"],
    descripcion: json["descripcion"],
    fechaAlta: DateTime.parse(json["fecha_alta"]),
    fechaBaja: DateTime.parse(json["fecha_baja"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    id: json["id"],
    idProducto: json["id_producto"],
    orden: json["orden"],
    titulo: json["titulo"],
  );
}

class PadreMapper {
  static Padre jsonToEntity(Map<String, dynamic> json) => Padre(
    categoria: CategoryMapper.jsonToEntity(json["Categoria"]),
    empresa: EmpresaMapper.jsonToEntity(json["Empresa"]),
    marca: MarcaMapper.jsonToEntity(json["Marca"]),
    activo: json["activo"],
    descripcion: json["descripcion"],
    destacado: json["destacado"],
    envioInternacional: json["envio_internacional"],
    fechaCreacion: DateTime.parse(json["fecha_creacion"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    id: json["id"],
    idCategoria: json["id_categoria"],
    idEmpresa: json["id_empresa"],
    idMarca: json["id_marca"],
    idTipo: json["id_tipo"],
    idUsuario: json["id_usuario"],
    mostrarEnPortada: json["mostrar_en_portada"],
    nombre: json["nombre"],
    paisesEnvio: json["paises_envio"],
    tieneDevolucion: json["tiene_devolucion"],
    tieneVariantes: json["tiene_variantes"],
    variantes: json["variantes"],
  );
}

class MarcaMapper {
  static Marca jsonToEntity(Map<String, dynamic> json) => Marca(
    activo: json["activo"],
    fechaAlta: DateTime.parse(json["fecha_alta"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    id: json["id"],
    idUsuario: json["id_usuario"],
    imagen: json["imagen"],
    nombre: json["nombre"],
    slug: json["slug"],
  );
}

class CategoryMapper {
  static Categoria jsonToEntity(Map<String, dynamic> json) => Categoria(
    activo: json["activo"],
    atributos: json["atributos"],
    bannerImg: json["banner_img"],
    descripcion: json["descripcion"],
    fechaCreacion: DateTime.parse(json["fecha_creacion"]),
    fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
    id: json["id"],
    idPadre: json["id_padre"],
    imagen: json["imagen"],
    imagenPortada: json["imagen_portada"],
    mostrarEnMenu: json["mostrar_en_menu"],
    mostrarEnPortada: json["mostrar_en_portada"],
    mostrarHome: json["mostrar_home"],
    nombre: json["nombre"],
    orden: json["orden"],
    slug: json["slug"],
    tags: json["tags"],
    tipo: json["tipo"],
  );
}

class EmpresaMapper {
  static Empresa jsonToEntity(Map<String, dynamic> json) => Empresa(
    clave: json["Clave"],
    fullName: json["FullName"],
    activo: json["activo"],
    descripcion: json["descripcion"],
    diasGestion: json["dias_gestion"],
    fechaRegistro: DateTime.parse(json["fecha_registro"]),
    id: json["id"],
    idMarketer: json["id_marketer"],
    idUsuario: json["id_usuario"],
    ligaFacturacion: json["liga_facturacion"],
    logo: json["logo"],
    nombre:json["nombre"],
    nombreCorto: json["nombre_corto"],
  );
}
