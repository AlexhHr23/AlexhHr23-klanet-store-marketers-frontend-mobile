import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/dashboard/presentation/providers/providers.dart';

class TimeZone extends ConsumerWidget {
  const TimeZone({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        width: double.infinity,

        // decoration: const BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        //   boxShadow: [
        //     BoxShadow(color: Colors.grey, blurRadius: 1, offset: Offset(0, 1)),
        //   ],
        // ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.punch_clock, size: 40, color: AppColors.danger),
            Text(
              dashboardState.balance.timeZone.toString(),
              style: textStyle.titleSmall?.copyWith(
                color: AppColors.danger,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
