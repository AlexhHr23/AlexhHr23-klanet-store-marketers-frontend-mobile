import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/menu/menu_item.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/custom_filled_button.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {
  int navDrawerIndex = 0;
  // final countryState = ref.

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;
    final authState = ref.watch(authProvider);

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
          final menuItem = appMenuItems[value];
          context.push(menuItem.link);
          widget.scaffoldKey.currentState?.closeDrawer();
        });
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          child: Text('Saludos', style: textStyles.titleMedium),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
          child: Text(
            '${authState.user!.profile.name} ${authState.user!.profile.lastname1}',
            style: textStyles.titleSmall,
          ),
        ),

        ...appMenuItems.map((item) {
          if (item.children.isEmpty) {
            return NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.titleKey),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ExpansionTile(
                leading: Icon(item.icon),
                title: Text(item.titleKey),
                children: item.children.map((child) {
                  return ListTile(
                    leading: Icon(child.icon, size: 20),
                    title: Text(child.titleKey),
                    onTap: () {
                      context.push(child.link);
                      widget.scaffoldKey.currentState?.closeDrawer();
                    },
                  );
                }).toList(),
              ),
            );
          }
        }),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Otras opciones'),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout('');
            },
            text: 'Cerrar sesión',
          ),
        ),
      ],
    );
  }
}
