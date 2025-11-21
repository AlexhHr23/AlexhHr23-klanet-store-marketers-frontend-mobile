
import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';

class Package {
    int id;
    String idMarketer;
    String nombre;
    String pais;
    String tipo;
    DateTime fechaBaja;
    DateTime fechaCreacion;
    DateTime fechaModificacion;
    String activo;
    List<Producto> productos;

    Package({
        required this.id,
        required this.idMarketer,
        required this.nombre,
        required this.pais,
        required this.tipo,
        required this.fechaBaja,
        required this.fechaCreacion,
        required this.fechaModificacion,
        required this.activo,
        required this.productos,
    });
}