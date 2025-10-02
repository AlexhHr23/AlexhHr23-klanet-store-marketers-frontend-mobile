import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/dashboard/presentation/providers/providers.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressRanges extends ConsumerWidget {
  const ProgressRanges({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final rangesState = ref.watch(dashboardProvider).marketerProfile;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Rango actual
              Text(
                rangesState.rangoActual.name.isEmpty
                    ? 'Sin rango'
                    : rangesState.rangoActual.name,
                style: textStyle.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              /// Rango siguiente
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.trending_up_sharp,
                      color: AppColors.primary, size: 16),
                  const SizedBox(width: 6),
                  Text('Rango siguiente: ',
                      style: textStyle.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  Text(
                    rangesState.rangoSiguiente.name,
                    style: textStyle.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),

              const Divider(height: 10),

              /// Badges
              Wrap(
                spacing: 5,
                runSpacing: 6,
                alignment: WrapAlignment.center,
                children: [
                  ItemBadge(
                      title: 'Gratuidad:',
                      subtitle: rangesState.tieneGratuidad ? 'Sí' : 'No'),
                  ItemBadge(
                      title: 'Membresía:',
                      subtitle: rangesState.membresiaActiva ? 'Sí' : 'No'),
                  ItemBadge(
                      title: 'Comisionar:',
                      subtitle:
                          rangesState.puedeComisionarRangos ? 'Sí' : 'No'),
                ],
              ),

              const SizedBox(height: 5),

              /// Progreso Izquierda
              RangeProgressBar(
                title: "Izquierda",
                active: rangesState.activosIzq,
                missing: rangesState.faltantesIzq + rangesState.activosIzq,
                icon: Icons.arrow_circle_left_rounded,
              ),

              const SizedBox(height: 12),

              /// Progreso Derecha
              RangeProgressBar(
                title: "Derecha",
                active: rangesState.activosDer,
                missing: rangesState.faltantesDer + rangesState.activosDer,
                icon: Icons.arrow_circle_right_rounded,
              ),
              // SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget Reutilizable
class RangeProgressBar extends StatelessWidget {
  final String title;
  final int active;
  final int missing;
  final IconData icon;

  const RangeProgressBar({
    super.key,
    required this.title,
    required this.active,
    required this.missing,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.secondary),
            const SizedBox(width: 6),
            Text(
              "$title: $active / $missing",
              style: textStyle.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 20,
          percent: (missing == 0) ? 0 : (active / missing).clamp(0.0, 1.0),
          center: Text("${(active / missing * 100).toStringAsFixed(0)}%", style: textStyle.bodySmall?.copyWith(color: AppColors.warnig)),
          progressColor: AppColors.primary,
          backgroundColor: Colors.grey.shade200,
          barRadius: const Radius.circular(8),
        ),
      ],
    );
  }
}

/// Badge Widget
class ItemBadge extends StatelessWidget {
  const ItemBadge({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.danger.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$title ",
            style: textStyle.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: textStyle.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
