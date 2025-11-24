import 'package:flutter/material.dart';

class MenuItem {
  final String titleKey;
  final String link;
  final IconData icon;
  final List<MenuItem> children;

  MenuItem({
    required this.titleKey,
    required this.link,
    required this.icon,
    this.children = const [],
  });
}

List<MenuItem> appMenuItems = <MenuItem>[
  MenuItem(titleKey: 'Dashboard', link: '/', icon: Icons.home),
  MenuItem(titleKey: 'Tiendas', link: '/stores', icon: Icons.store_outlined),
  MenuItem(
    titleKey: 'Catálogo',
    link: '/catalog',
    icon: Icons.category_outlined,
    children: [
      MenuItem(
        titleKey: 'Productos',
        link: '/dashboard-job',
        icon: Icons.shopping_bag_outlined,
      ),
      MenuItem(
        titleKey: 'Paquetes',
        link: '/packages',
        icon: Icons.shopping_bag_outlined,
      ),
      // MenuItem(
      //   titleKey: 'Categorías',
      //   link: '/categories',
      //   icon: Icons.list_alt_outlined,
      // ),
      // MenuItem(titleKey: 'Marcas', link: '/brands', icon: Icons.label_outline),
    ],
  ), //MenuItem(titleKey: 'Catalogo', link: '/stores', icon: Icons.store_outlined),

   MenuItem(
    titleKey: 'Comisiones',
    link: '/commissions',
    icon: Icons.account_balance_outlined,
    children: [
      MenuItem(
        titleKey: 'Directas y de red',
        link: '/commissions-all',
        icon: Icons.shopping_bag_outlined,
      ),
      // MenuItem(
      //   titleKey: 'Categorías',
      //   link: '/categories',
      //   icon: Icons.list_alt_outlined,
      // ),
      // MenuItem(titleKey: 'Marcas', link: '/brands', icon: Icons.label_outline),
    ],
  ), //
];
