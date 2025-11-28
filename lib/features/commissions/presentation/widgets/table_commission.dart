import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:klanetmarketers/features/commissions/domain/domain.dart';

class TableCommission extends StatelessWidget {
  final NetworkCommission commission;
  const TableCommission({super.key, required this.commission});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100, // Altura fija para evitar el error
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Scroll horizontal
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 600, // Ancho mínimo para la tabla
            ),
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600, // Mismo ancho mínimo
              headingRowHeight: 40,
              dataRowHeight: 50,
              columns: const [
                DataColumn(label: Text('Código compra')),
                DataColumn(label: Text('SKU')),
                DataColumn(label: Text('Cantidad')),
                DataColumn(label: Text('Producto')),
                DataColumn(label: Text('Tipo')),
                DataColumn(label: Text('Marketer')),
                DataColumn(label: Text('Código marketer')),
                DataColumn(label: Text('Cancelada')),
                DataColumn(label: Text('% Comisión')),
                DataColumn(label: Text('Total Comisión')),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text(commission.codigoCompra)),
                    DataCell(Text(commission.sku)),
                    DataCell(Text(commission.cantidad.toString())),
                    DataCell(Text(commission.producto)),
                    DataCell(Text(commission.tipoProducto.toString())),
                    DataCell(Text(commission.marketer)),
                    DataCell(Text(commission.codMarketer)),
                    DataCell(Text(commission.compraCancelada)),
                    DataCell(Text(commission.comisionPorcentaje)),
                    DataCell(Text(commission.comision.toStringAsFixed(2))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}