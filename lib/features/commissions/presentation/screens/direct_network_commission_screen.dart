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

    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Builder(
          builder: (_) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.groupedByLevel.isEmpty) {
              return const Center(
                child: Text('No hay comisiones para mostrar'),
              );
            }

            return ListView(
              children: state.groupedByLevel.entries.map((entry) {
                final nivel = entry.key;
                final items = entry.value;

                return ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: Text(
                    nivel,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: items.map((item) {
                    final isCancelada = item.compraCancelada == "1";

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 4,
                      ),
                      color: isCancelada ? Colors.red.shade50 : Colors.white,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _rowItem("Código", item.codigoCompra),
                            _rowItem("Producto", item.producto, maxLines: 2),
                            _rowItem("Marketer", item.marketer),
                            _rowItem("Fecha", item.fechaCompra.toString()),
                            _rowItem(
                              "Subtotal",
                              "\$${item.subtotal.toStringAsFixed(2)}",
                            ),
                            _rowItem(
                              "Comisión",
                              "\$${item.comision.toStringAsFixed(2)}",
                              valueColor: item.comision < 0
                                  ? Colors.red
                                  : Colors.green,
                            ),
                            _rowItem("Porcentaje", item.comisionPorcentaje),
                            _rowItem(
                              "Estatus",
                              isCancelada ? 'Cancelada' : 'Activa',
                              valueColor: isCancelada
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _rowItem(
    String label,
    String value, {
    Color? valueColor,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: valueColor),
            ),
          ),
        ],
      ),
    );
  }
}
