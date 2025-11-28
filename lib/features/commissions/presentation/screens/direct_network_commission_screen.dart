import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/commissions/presentation/providers/commissions_provider.dart';
import 'package:klanetmarketers/features/commissions/presentation/widgets/widgets.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';

class DirectNetworkCommissionScreen extends StatelessWidget {
  DirectNetworkCommissionScreen({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AppLayout(scaffoldKey: scaffoldKey, body: _CommissionView());
  }
}

class _CommissionView extends ConsumerWidget {
  const _CommissionView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commissionProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.hasSearched && state.commissions.isEmpty) {
      return const Center(child: Text('No hay comisiones.'));
    }

    final grouped = state.groupedByLevel;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: grouped.entries.map((entry) {
          final level = entry.key;
          final commissions = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                level,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commissions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TableCommission(commission: commissions[index]),
                  );
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}