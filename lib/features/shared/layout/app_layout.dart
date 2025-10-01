import 'package:flutter/material.dart';
import 'package:klanetmarketers/features/shared/widgets/side_menu.dart';

class AppLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget body;

  const AppLayout({
    super.key,
    this.scaffoldKey,
    this.appBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final key = scaffoldKey ?? GlobalKey<ScaffoldState>();

    return Scaffold(
      key: key,
      drawer: SideMenu(scaffoldKey: key),
      appBar: appBar,
      body: body,
    );
  }
}
