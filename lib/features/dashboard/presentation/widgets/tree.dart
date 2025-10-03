import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/dashboard/presentation/providers/dashboard_provider.dart';

class Tree extends ConsumerWidget {
  const Tree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final rangesState = ref.watch(dashboardProvider).marketerProfile;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Árbol de alineación',
                style: textStyle.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(height: 20, thickness: 1, color: Colors.grey.shade300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemSide(
                    side: 'Izquierdo',
                    totaSide: rangesState.totalIzq,
                    directTotals: rangesState.activosIzq,
                    directActiveTotals: rangesState.sponsorActivosIzq,
                    icon: Icons.arrow_circle_left_rounded,
                    color: AppColors.primary,
                  ),
                  SizedBox(width:10),
                  ItemSide(
                    side: 'Derecho',
                    totaSide: rangesState.totalDer,
                    directTotals: rangesState.activosDer,
                    directActiveTotals: rangesState.sopnsorActivosDer,
                    icon: Icons.arrow_circle_right_rounded,
                    color: AppColors.secondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemSide extends StatelessWidget {
  const ItemSide({
    super.key,
    required this.side,
    required this.totaSide,
    required this.directTotals,
    required this.directActiveTotals,
    required this.icon,
    required this.color,
  });

  final String side;
  final int totaSide;
  final int directTotals;
  final int directActiveTotals;
  final IconData icon;
  final Color color;

  Widget _buildRow(BuildContext context, IconData icon, String label, int value) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: textStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value.toString(),
              style: textStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 6),
              Text(
                'Lado $side',
                style: textStyle.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildRow(context, Icons.supervised_user_circle, "Usuarios totales", totaSide),
          _buildRow(context, Icons.group_add, "Directos", directTotals),
          _buildRow(context, Icons.verified_user, "Directos activos", directActiveTotals),
        ],
      ),
    );
  }
}
