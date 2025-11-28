import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';

/// Example without a datasource
class DirectNetworkCommissionScreen extends StatelessWidget {
  const DirectNetworkCommissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        scrollController: ScrollController(),
        columns: const [
          DataColumn2(label: Text('Name'), size: ColumnSize.S),
          DataColumn2(label: Text('Age'), size: ColumnSize.S),
          DataColumn2(label: Text('Country'), size: ColumnSize.S),
          DataColumn2(label: Text('Email'), size: ColumnSize.S),
          DataColumn2(label: Text('Commission'), size: ColumnSize.S),
          DataColumn2(label: Text('Status'), size: ColumnSize.S),
          DataColumn2(label: Text('Hola'), size: ColumnSize.S),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('John')),
              DataCell(Text('30')),
              DataCell(Text('USA')),
              DataCell(Text('john@mail.com')),
              DataCell(Text('\$232')),
              DataCell(Text('Active')),
              DataCell(Text('Active')),
            ],
          ),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:data_table_2/data_table_2.dart';
// import 'package:klanetmarketers/features/commissions/presentation/providers/commissions_provider.dart';

// class DirectNetworkCommissionScreen extends ConsumerWidget {
//   const DirectNetworkCommissionScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(commissionProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Comisiones Red Directa'),
//       ),
//       body: state.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : state.groupedByLevel.isEmpty
//               ? const Center(child: Text('No hay resultados'))
//               : ListView(
//                   padding: const EdgeInsets.all(16),
//                   children: state.groupedByLevel.entries.map((entry) {
//                     final level = entry.key;
//                     final commissions = entry.value;

//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 12),
//                         Text(
//                           level,
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge!
//                               .copyWith(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 8),

//                         /// 🔹 Contenedor de la tabla con scroll horizontal
//                         Card(
//                           elevation: 2,
//                           margin: const EdgeInsets.only(bottom: 24),
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: DataTable2(
//                               columnSpacing: 12,
//                               horizontalMargin: 12,
//                               minWidth: 1400,
//                               columns: const [
//                                 DataColumn2(label: Text('ID'), size: ColumnSize.S),
//                                 DataColumn2(label: Text('Fecha'), size: ColumnSize.M),
//                                 DataColumn2(label: Text('Producto'), size: ColumnSize.L),
//                                 DataColumn2(label: Text('Cantidad'), numeric: true),
//                                 DataColumn2(label: Text('Subtotal'), numeric: true),
//                                 DataColumn2(label: Text('Comisión'), numeric: true),
//                                 DataColumn2(label: Text('%'), size: ColumnSize.S),
//                                 DataColumn2(label: Text('Cancelada'), size: ColumnSize.S),
//                                 DataColumn2(label: Text('Semana'), size: ColumnSize.S),
//                                 DataColumn2(label: Text('Código Compra'), size: ColumnSize.M),
//                                 DataColumn2(label: Text('Marketer'), size: ColumnSize.M),
//                               ],
//                               rows: commissions.map((commission) {
//                                 return DataRow(
//                                   cells: [
//                                     DataCell(Text(commission.id.toString())),
//                                     DataCell(Text(_formatDate(commission.fechaCompra.toString()))),
//                                     DataCell(
//                                       SizedBox(
//                                         width: 280,
//                                         child: Text(
//                                           commission.producto,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(Text(commission.cantidad.toString())),
//                                     DataCell(Text(commission.subtotal.toStringAsFixed(2))),
//                                     DataCell(Text(commission.comision.toStringAsFixed(2))),
//                                     DataCell(Text(commission.comisionPorcentaje)),
//                                     DataCell(Text(
//                                       commission.compraCancelada == '1' ? 'Sí' : 'No',
//                                       style: TextStyle(
//                                         color: commission.compraCancelada == '1'
//                                             ? Colors.red
//                                             : Colors.green,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     )),
//                                     DataCell(Text(commission.semana)),
//                                     DataCell(Text(commission.codigoCompra)),
//                                     DataCell(Text(commission.marketer)),
//                                   ],
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//     );
//   }

//   String _formatDate(String dateString) {
//     try {
//       final date = DateTime.parse(dateString);
//       return '${date.day}/${date.month}/${date.year}';
//     } catch (_) {
//       return dateString;
//     }
//   }
// }

