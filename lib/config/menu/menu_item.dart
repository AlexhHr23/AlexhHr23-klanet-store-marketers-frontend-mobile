import 'package:flutter/material.dart';

class MenuItem {
  final String titleKey;
  final String link;
  final IconData icon;

  MenuItem({required this.titleKey, required this.link, required this.icon});
}

List<MenuItem> appMenuItems = <MenuItem>[
  MenuItem(titleKey: 'Dashboard', link: '/', icon: Icons.home),
  MenuItem(titleKey: 'Tiendas', link: '/stores', icon: Icons.store_outlined),
];
