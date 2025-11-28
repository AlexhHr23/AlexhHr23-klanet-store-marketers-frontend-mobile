class NetworkCommission {
    int id;
    DateTime fechaCompra;
    String estatusCompra;
    String sku;
    String producto;
    double subtotal;
    int cantidad;
    double comision;
    String comisionPorcentaje;
    String moneda;
    String codigoCompra;
    String marketer;
    String codMarketer;
    String semana;
    String nivel;
    String esAcademy;
    String esBusinnesManager;
    String compraCancelada;
    int tipoProducto;

    NetworkCommission({
        required this.id,
        required this.fechaCompra,
        required this.estatusCompra,
        required this.sku,
        required this.producto,
        required this.subtotal,
        required this.cantidad,
        required this.comision,
        required this.comisionPorcentaje,
        required this.moneda,
        required this.codigoCompra,
        required this.marketer,
        required this.codMarketer,
        required this.semana,
        required this.nivel,
        required this.esAcademy,
        required this.esBusinnesManager,
        required this.compraCancelada,
        required this.tipoProducto,
    });
}