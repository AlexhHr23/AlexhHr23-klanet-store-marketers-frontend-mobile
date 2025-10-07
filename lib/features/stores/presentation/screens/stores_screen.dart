import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';

import '../../../shared/providers/providers.dart';

class StoresScreen extends ConsumerWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: const Center(child: Text('Stores Screen')),
    );
  }
}
