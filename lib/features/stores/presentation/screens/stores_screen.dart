import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';
import 'package:klanetmarketers/features/shared/providers/country_provider.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/stores/presentation/widgets/widgets.dart';

import '../../../shared/widgets/widgets.dart'; // si usas colores personalizados

class StoresScreen extends ConsumerWidget {
  const StoresScreen({super.key});

  void openDialog(BuildContext context, WidgetRef ref, int storeId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Borrar tienda'),
        content: const Text('Estas borrar esta tiienda?'),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(storeProvider.notifier).deleteStore(storeId);
              context.pop();
            },
            child: const Text('Aceptar'),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final countriesState = ref.watch(countryProvider);
    final countries = countriesState.countries;
    final storeState = ref.watch(storeProvider);
    final storeNotifier = ref.read(storeProvider.notifier);

    if (countries.isNotEmpty && storeState.selectedCountry == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(storeProvider.notifier).selectCountry(countries.first.id);
      });
    }

    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Selecciona un país',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: storeState.selectedCountry,
                  items: countries.map((country) {
                    return DropdownMenuItem<String>(
                      value: country.id,
                      child: Text(
                        country.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      storeNotifier.selectCountry(value);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 24),

            Expanded(
              child: Builder(
                builder: (context) {
                  if (storeState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (storeState.stores.isEmpty &&
                      !storeState.hasSearched &&
                      storeState.selectedCountry != null) {
                    return const Center(
                      child: Text(
                        'Seleccione un país y presione buscar',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  if (storeState.stores.isNotEmpty) {
                    return ListView.separated(
                      itemCount: storeState.stores.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final store = storeState.stores[index];
                        return StoreCard(
                          store: store,
                          onEdit: () => {
                            storeNotifier.selectStore(store, store.id),
                            context.push('/form-stores')
                          },
                          onDelete: () => openDialog(context, ref, store.id),
                          onViewBanners: () => context.push('/stores/banners/${store.id}?country=${storeState.selectedCountry}'),
                          onViewProducts:() => context.push('/stores/products/${store.id}?country=${storeState.selectedCountry}')
                        );
                      },
                    );
                  } else if (storeState.hasSearched) {
                    return const Center(
                      child: Text(
                        'No se encontraron tiendas para este país.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return const Center(
                    child: Text(
                      'Selecciona un país y presiona Buscar.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: <CustomFloatingButton>[
        CustomFloatingButton(
          heroTag: 'search',
          iconData: Icons.search,
          color: AppColors.primary,
          onPressed: () async {
            await storeNotifier.getStores();
          },
        ),
        if (storeState.hasSearched)
          CustomFloatingButton(
            heroTag: 'add',
            iconData: Icons.add,
            color: AppColors.primary,
            onPressed: () {
              storeNotifier.selectStore(null,0);
              context.push('/form-stores');
            },
          ),
      ],
    );
  }
}
