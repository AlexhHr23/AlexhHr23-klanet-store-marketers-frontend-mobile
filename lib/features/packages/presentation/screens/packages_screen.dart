import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/packages/presentation/providers/package_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/custom_floating_action_button.dart';

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
    final textStyle = Theme.of(context).textTheme;
    late String? selectedCountry;

    if (countries.isNotEmpty ) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectedCountry = countries.first.id;
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
                  value: null,
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
                     selectedCountry = value;
                    }
                  },
                ),
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
            await ref.read(packageProvider.notifier).getPackages(selectedCountry!);
          },
        ),
        if (packageState.hasSearched)
          CustomFloatingButton(
            heroTag: 'add',
            iconData: Icons.add,
            color: AppColors.primary,
            onPressed: () {
              // storeNotifier.selectStore(null, 0);
              // context.push('/form-stores');
            },
          ),
      ],
    );
  }
}
