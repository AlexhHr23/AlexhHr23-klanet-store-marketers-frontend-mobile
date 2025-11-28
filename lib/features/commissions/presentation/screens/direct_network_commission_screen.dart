import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/commissions/presentation/providers/commissions_provider.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';

class DirectNetworkCommissionScreen extends ConsumerWidget {
  const DirectNetworkCommissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final state = ref.watch(commissionProvider);
    final textStyle = Theme.of(context).textTheme;
    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (_) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.commissions.isEmpty) {
              return const Center(
                child: Text('No hay comisiones para mostrar'),
              );
            }

            return SizedBox(
              width: double.infinity,
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 1200,
                headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),

                columns: const [
                  DataColumn2(label: Text('Codigo Compra'), size: ColumnSize.L),
                  DataColumn2(label: Text('Producto'), size: ColumnSize.L),
                  DataColumn2(label: Text('Marketer'), size: ColumnSize.L),
                  DataColumn2(label: Text('Fecha Compra'), size: ColumnSize.L),
                  DataColumn2(label: Text('Subtotal'), size: ColumnSize.M),
                  DataColumn2(label: Text('Comisión'), size: ColumnSize.S),
                  DataColumn2(label: Text('Porcentaje'), size: ColumnSize.M),
                  DataColumn2(label: Text('Estatus'), size: ColumnSize.S),
                ],

                rows: state.commissions.map((item) {
                  final isCancelada = item.compraCancelada == "1";

                  return DataRow(
                    color: isCancelada
                        ? WidgetStateProperty.all(Colors.red.shade50)
                        : null,
                    cells: [
                      DataCell(Text(item.codigoCompra)),
                      DataCell(Text(item.producto)),
                      DataCell(Text(item.marketer)),
                      DataCell(Text(item.fechaCompra.toString())),
                      DataCell(Text('\$${item.subtotal.toStringAsFixed(2)}')),
                      DataCell(
                        Text(
                          '\$${item.comision.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: item.comision < 0
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(Text(item.comisionPorcentaje)),
                      DataCell(
                        Text(
                          isCancelada ? 'Cancelada' : 'Activa',
                          style: TextStyle(
                            color: isCancelada ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
