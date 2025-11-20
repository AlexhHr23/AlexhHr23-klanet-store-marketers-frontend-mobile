import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/shared/providers/currency_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/side_menu.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';

import '../providers/providers.dart';

// import '../providers/providers.dart';

class AppLayout extends ConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget body;
  final List<CustomFloatingButton>? floatingActionButton;

  const AppLayout({
    super.key,
    required this.scaffoldKey,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = scaffoldKey;
    ref.watch(countryProvider);
    ref.watch(currencyProvider);
    return Scaffold(
      key: key,
      drawer: SideMenu(scaffoldKey: key),
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
      body: body,
      floatingActionButton: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.end,
        children: floatingActionButton ?? [],
      ),
    );
  }
}
