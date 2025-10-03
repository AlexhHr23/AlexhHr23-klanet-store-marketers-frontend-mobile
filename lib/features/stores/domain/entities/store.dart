import 'package:klanetmarketers/features/stores/domain/entities/banner_store.dart';

class MarketerStore {
    List<BannerStore> banners;
    String codigo;
    String descripcion;
    int id;
    String idUsuario;
    String moneda;
    String msClarity;
    String nombre;
    String pais;
    String slug;

    MarketerStore({
        required this.banners,
        required this.codigo,
        required this.descripcion,
        required this.id,
        required this.idUsuario,
        required this.moneda,
        required this.msClarity,
        required this.nombre,
        required this.pais,
        required this.slug,
    });

}