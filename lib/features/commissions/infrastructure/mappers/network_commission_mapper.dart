import 'package:klanetmarketers/features/commissions/domain/domain.dart';

class NetworkCommissionMapper {
  static NetworkCommission jsonToEntity(Map<String, dynamic> json) =>
      NetworkCommission(
        id: json["Id"] ?? 0,
        fechaCompra: json["FechaCompra"] != null ? DateTime.parse(json["FechaCompra"]) : DateTime.now(),
        estatusCompra: json["EstatusCompra"] ?? '',
        sku: json["Sku"] ?? '',
        producto: json["Producto"] ?? '',
        subtotal: json["Subtotal"]?.toDouble() ?? 0.0,
        cantidad: json["Cantidad"] ?? 0,
        comision: json["Comision"]?.toDouble() ?? 0.0,
        comisionPorcentaje: json["ComisionPorcentaje"] ?? '',
        moneda: json["Moneda"] ?? '',
        codigoCompra: json["CodigoCompra"] ?? '',
        marketer: json["Marketer"] ?? '',
        codMarketer: json["CodMarketer"] ?? '',
        semana: json["Semana"] ?? 0,
        nivel: json["Nivel"] ?? '',
        esAcademy: json["EsAcademy"] ?? '',
        esBusinnesManager: json["EsBusinnesManager"] ?? '', 
        compraCancelada: json["CompraCancelada"] ?? '',
        tipoProducto: json["TipoProducto"] ?? 0,
      );
}
