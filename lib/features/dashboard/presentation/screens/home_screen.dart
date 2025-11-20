import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';
import 'package:klanetmarketers/features/dashboard/presentation/widgets/widgets.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
    });

    return AppLayout(scaffoldKey: scaffoldKey, body: const _ProductsView());
  }
}

class _ProductsView extends ConsumerWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    return SingleChildScrollView(
      child: Skeletonizer(
        enabled: dashboardState.isLoading,
        child: const Column(
          children: [
            BannerSlider(),
            TimeServer(),
            MarketerProfile(),
            NextRange(),
            ProgressRange(),
            Tree(),
          ],
        ),
      ),
    );
  }
}
