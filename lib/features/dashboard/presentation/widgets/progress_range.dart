import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressRange extends ConsumerWidget {
  const ProgressRange({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final rangesState = ref.watch(dashboardProvider).marketerProfile;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Progreso de rango',
                style: textStyle.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Avanza hacia el siguiente nivel',
                style: textStyle.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              Divider(height: 32, thickness: 1, color: Colors.grey.shade300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularProgressBar(
                    title: 'Progreso',
                    icon: Icons.trending_up,
                    activeLeft: rangesState.activosIzq,
                    activeRight: rangesState.activosDer,
                    missingLeft: rangesState.rangoSiguiente.izq,
                    missingRight: rangesState.rangoSiguiente.der,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rango actual',
                        style: textStyle.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rangesState.rangoActual.name.isEmpty
                            ? 'Sin rango'
                            : rangesState.rangoActual.name,
                        style: textStyle.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Rango siguiente',
                        style: textStyle.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rangesState.rangoSiguiente.name,
                        style: textStyle.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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

class CircularProgressBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final int activeLeft;
  final int activeRight;
  final int missingLeft;
  final int missingRight;

  const CircularProgressBar({
    super.key,
    required this.title,
    required this.icon,
    required this.activeLeft,
    required this.activeRight,
    required this.missingLeft,
    required this.missingRight,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final progress = _calculateProgressBar(
      activeLeft,
      activeRight,
      missingLeft,
      missingRight,
    );

    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              title,
              style: textStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        CircularPercentIndicator(
          radius: 70.0,
          lineWidth: 10.0,
          animation: true,
          percent: progress,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${(progress * 100).toStringAsFixed(0)}%",
                style: textStyle.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                "Completado",
                style: textStyle.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: AppColors.primary,
          backgroundColor: Colors.grey.shade200,
        ),
      ],
    );
  }
}

double _calculateProgressBar(
  int activosIzq,
  int activosDer,
  int reqIzq,
  int reqDer,
) {
  double safe(num? v) => (v != null && v != 0) ? v.toDouble() : 1.0;

  final progresoIzq = (activosIzq / safe(reqIzq)).clamp(0.0, 1.0);
  final progresoDer = (activosDer / safe(reqDer)).clamp(0.0, 1.0);

  return ((progresoIzq + progresoDer) / 2).clamp(0.0, 1.0);
}

