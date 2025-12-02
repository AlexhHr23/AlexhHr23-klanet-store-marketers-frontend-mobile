import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/commissions/presentation/providers/commissions_provider.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';
import 'package:klanetmarketers/features/shared/widgets/custom_floating_action_button.dart';
import 'package:intl/intl.dart';

class DirectNetworkCommissionScreen extends ConsumerStatefulWidget {
  const DirectNetworkCommissionScreen({super.key});

  @override
  ConsumerState<DirectNetworkCommissionScreen> createState() =>
      _DirectNetworkCommissionScreenState();
}

class _DirectNetworkCommissionScreenState
    extends ConsumerState<DirectNetworkCommissionScreen> {
  Widget buildWeekDatePicker(
    DateTime selectedDate,
    DateTime firstAllowedDate,
    DateTime lastAllowedDate,
    ValueChanged<DateTime> onDateSelected,
  ) {
    final DatePickerRangeStyles styles = DatePickerRangeStyles(
      selectedPeriodLastDecoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      selectedPeriodStartDecoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      selectedPeriodMiddleDecoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.rectangle,
      ),
      selectedDateStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      dayHeaderStyle: DayHeaderStyle(
        textStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return WeekPicker(
      selectedDate: selectedDate,
      datePickerLayoutSettings: const DatePickerLayoutSettings(
        dayPickerRowHeight: 40,
      ),
      onChanged: (DatePeriod period) {
        onDateSelected(period.end);
      },
      firstDate: firstAllowedDate,
      lastDate: lastAllowedDate,
      datePickerStyles: styles,
    );
  }

  DateTime? _selectedDate;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _selectWeek(BuildContext context) async {
    DateTime initial = _selectedDate ?? DateTime.now();

    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            "Selecciona una semana",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 400,
            height: 320,
            child: Column(
              children: [
                // Información para el usuario
                Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    'Toca cualquier día de la semana para seleccionarla',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),

                // El WeekPicker
                Expanded(
                  child: buildWeekDatePicker(
                    initial,
                    DateTime(2000),
                    DateTime.now(),
                    (DateTime selectedDate) {
                      setState(() {
                        _selectedDate = selectedDate;
                      });
                      // Mostrar confirmación
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _searchCommissions() {
    if (_selectedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      ref.read(commissionProvider.notifier).getNeworkCommissions(formattedDate);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecciona una fecha primero'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commissionProvider);

    return AppLayout(
      scaffoldKey: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Seleccionar semana:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () => _selectWeek(context),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: AppColors.primary,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            if (_selectedDate != null) ...[
                                              const SizedBox(height: 4),
                                              Text(
                                                _getWeekRangeText(
                                                  _selectedDate!,
                                                ),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!state.hasSearched) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Selecciona una semana y presiona "Buscar"',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state.groupedByLevel.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hay comisiones para mostrar',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          if (_selectedDate != null)
                            Text(
                              'Semana(${_getWeekRangeText(_selectedDate!)})',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    );
                  }

                  return ListView(
                    children: state.groupedByLevel.entries.map((entry) {
                      final nivel = entry.key;
                      final items = entry.value;

                      return ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        title: Text(
                          nivel,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        children: items.map((item) {
                          final isCancelada = item.compraCancelada == "1";

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 4,
                            ),
                            color: isCancelada
                                ? Colors.red.shade50
                                : Colors.white,
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _rowItem("Código", item.codigoCompra),
                                  _rowItem(
                                    "Producto",
                                    item.producto,
                                    maxLines: 2,
                                  ),
                                  _rowItem("Marketer", item.marketer),
                                  _rowItem(
                                    "Fecha",
                                    item.fechaCompra.toString(),
                                  ),
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
                                  _rowItem(
                                    "Porcentaje",
                                    item.comisionPorcentaje,
                                  ),
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
          ],
        ),
      ),
      floatingActionButton: [
        CustomFloatingButton(
          iconData: Icons.search,
          onPressed: _searchCommissions,
          heroTag: 'search',
          color: AppColors.primary,
        ),
      ],
    );
  }

  Widget _rowItem(
    String label,
    String value, {
    Color? valueColor,
    int? maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12, color: valueColor),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Método helper para obtener el rango de la semana
  String _getWeekRangeText(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return '${formatter.format(startOfWeek)} - ${formatter.format(endOfWeek)}';
  }
}
