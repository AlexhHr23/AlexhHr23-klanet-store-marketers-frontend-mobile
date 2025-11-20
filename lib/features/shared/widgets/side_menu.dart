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
  int navDrawerIndex = 0; // índice del item padre seleccionado
  int selectedChildIndex = -1;

  // Devuelve (parentIndex, childIndex)
  Map<String, int> _findParentAndChild(String location) {
    for (int i = 0; i < appMenuItems.length; i++) {
      final parent = appMenuItems[i];

      // Coincidencia exacta con el padre
      if (location == parent.link) return {'p': i, 'c': -1};

      // Recorremos hijos para ver si alguno coincide
      for (int j = 0; j < parent.children.length; j++) {
        final child = parent.children[j];

        // Coincidencia exacta o ruta que empieza con child.link (soporta /dashboard-job/23)
        if (location == child.link || location.startsWith(child.link)) {
          return {'p': i, 'c': j}; // devolvemos padre e indice del hijo
        }
      }

      // Si el padre tiene children pero la ruta contiene el fragmento del child (caso raro)
      for (int j = 0; j < parent.children.length; j++) {
        final child = parent.children[j];
        if (location.contains(child.link)) {
          return {'p': i, 'c': j};
        }
      }
    }

    // Si no coincide nada, default a dashboard (índice 0)
    return {'p': 0, 'c': -1};
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();

    // Calculamos parent/child activos antes de construir
    final sel = _findParentAndChild(currentLocation);
    navDrawerIndex = sel['p']!;
    selectedChildIndex = sel['c']!;

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;
    final authState = ref.watch(authProvider);

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        final selectedItem = appMenuItems[value];

        // Si el item tiene hijos no navegamos al padre (ya que "/catalog" no existe).
        // Aquí asumimos que los items sin hijos sí tienen ruta navegable.
        if (selectedItem.children.isEmpty) {
          setState(() {
            navDrawerIndex = value;
            selectedChildIndex = -1;
          });
          context.go(selectedItem.link);
          widget.scaffoldKey.currentState?.closeDrawer();
        } else {
          // Si el padre tiene hijos, simplemente expandimos/cerramos (no navegamos)
          setState(() {
            navDrawerIndex = value;
            selectedChildIndex = -1;
          });
        }
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

        // Construimos el menú con índices
        ...List.generate(appMenuItems.length, (i) {
          final item = appMenuItems[i];

          // Si no tiene hijos, lo dejamos como NavigationDrawerDestination
          if (item.children.isEmpty) {
            return NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.titleKey),
            );
          }

          // Si tiene hijos, mostramos un ExpansionTile
          final bool parentActive = navDrawerIndex == i;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ExpansionTile(
              leading: Icon(item.icon),
              title: Text(item.titleKey),
              initiallyExpanded: parentActive,
              // Opcional: controla visualmente la cabecera si está activo
              children: List.generate(item.children.length, (j) {
                final child = item.children[j];
                final bool childActive =
                    parentActive && selectedChildIndex == j;

                return ListTile(
                  leading: Icon(child.icon, size: 20),
                  title: Text(child.titleKey),
                  selected: childActive,
                  // Puedes personalizar el color cuando está seleccionado
                  // tileColor: childActive ? Colors.grey.withOpacity(0.12) : null,
                  onTap: () {
                    // Al seleccionar hijo, actualizamos índices y navegamos
                    setState(() {
                      navDrawerIndex = i; // padre
                      selectedChildIndex = j; // hijo
                    });

                    context.go(child.link);
                    widget.scaffoldKey.currentState?.closeDrawer();
                  },
                );
              }),
            ),
          );
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
