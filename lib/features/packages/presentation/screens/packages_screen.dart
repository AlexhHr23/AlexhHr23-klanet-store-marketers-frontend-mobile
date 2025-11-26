import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/packages/presentation/providers/package_provider.dart';
import 'package:klanetmarketers/features/packages/presentation/widgets/widgets.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';
import '../../../shared/layout/app_layout.dart';
import '../../../shared/providers/providers.dart';

class PackagesScreen extends ConsumerWidget {
  PackagesScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesState = ref.watch(countryProvider);
    final countries = countriesState.countries;
    final packageState = ref.watch(packageProvider);
    // final textStyle = Theme.of(context).textTheme;

    if (countries.isNotEmpty && packageState.selectedCountry == '') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(packageProvider.notifier).selectCountry(countries.first.id);
      });
    }

    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  value: packageState.selectedCountry.isEmpty
                      ? null
                      : packageState.selectedCountry,
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
                    if (value != '') {
                      ref.read(packageProvider.notifier).selectCountry(value!);
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Builder(
                builder: (context) {
                  if (packageState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (packageState.packages.isEmpty &&
                      !packageState.hasSearched &&
                      packageState.selectedCountry != '') {
                    return const Center(
                      child: Text(
                        'Seleccione un país y presione buscar',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  if (packageState.packages.isNotEmpty) {
                    return ListView.separated(
                      itemCount: packageState.packages.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final package = packageState.packages[index];
                        return CardPackage(
                          package: package,
                          onAddProducts: () {
                            context.push('/dashboard-job/${package.pais}');
                          },
                          onDelete: () {
                            showCustomDialog(
                              title: 'Eliminar paquete',
                              desc: '¿Desea eliminar este paquete?',
                              type: DialogType.question,
                              context: context,
                              onOkPress: () async {
                                final res = await ref
                                    .read(packageProvider.notifier)
                                    .deletePackage(package.pais, package.id);

                                if (res) {
                                  if (!context.mounted) return;
                                  customShowSnackBar(
                                    context,
                                    message: res
                                        ? 'Paquete eliminado correctamente'
                                        : 'Hubo un error al eliminar',
                                    res: res,
                                  );
                                }
                              },
                            ).show();
                          },
                          onViewProducts: () {
                            context.push(
                              '/packages/${package.id}?country=${package.pais}',
                            );
                          },
                        );
                      },
                    );
                  } else if (packageState.hasSearched) {
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
            await ref
                .read(packageProvider.notifier)
                .getPackages(packageState.selectedCountry);
          },
        ),
        if (packageState.hasSearched)
          CustomFloatingButton(
            heroTag: 'add',
            iconData: Icons.add,
            color: AppColors.primary,
            onPressed: () {
              context.push('/form-packages/${packageState.selectedCountry}');
            },
          ),
      ],
    );
  }
}
