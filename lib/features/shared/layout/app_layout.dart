import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/shared/widgets/side_menu.dart';

import '../providers/providers.dart';

// import '../providers/providers.dart';

class AppLayout extends ConsumerWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget body;

  const AppLayout({super.key, this.scaffoldKey, required this.body});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = scaffoldKey ?? GlobalKey<ScaffoldState>();
    ref.watch(countryProvider);
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
    );
  }
}
