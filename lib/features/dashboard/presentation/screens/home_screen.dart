import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';
import 'package:klanetmarketers/features/dashboard/presentation/widgets/widgets.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
    });

    return AppLayout(
      scaffoldKey: scaffoldKey,
      appBar: AppBar(
        title: SizedBox(
          height: 30,
          child: SvgPicture.asset(
            'assets/images/logo_klanet_d.svg',
            height: 70,
            color: AppColors.secondary,
          ),
        ),
        centerTitle: true,
      ),
      body: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: const Column(
        children: [BannerSlider(), TimeServer(), MarketerProfile(), ProgressRanges()],
      ),
    );
  }
}
