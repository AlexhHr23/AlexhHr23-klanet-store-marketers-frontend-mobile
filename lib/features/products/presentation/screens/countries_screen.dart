import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';
import 'package:klanetmarketers/features/shared/providers/providers.dart';

class CountriesScreen extends ConsumerWidget {
  CountriesScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesState = ref.watch(countryProvider);
    final textStyle = Theme.of(context).textTheme;

    final countries = countriesState.countries;

    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Países',
              style: textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Selecciona el país de tu interés. La opción seleccionada se aplicará al listado de categorías.',
              style: textStyle.bodySmall?.copyWith(fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final imagePath = 'assets/images/flags/${country.id}.png';
                  return GestureDetector(
                    onTap: () => context.push('/dashboard-job/${country.id}'),
                    child: _CardCountry(country: country, image: imagePath),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardCountry extends StatelessWidget {
  final Country country;
  final String image;

  const _CardCountry({required this.country, required this.image});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Espacio entre items
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Bandera
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 50,
              height: 35,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.flag_outlined, size: 40, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          // Nombre del país
          Expanded(
            child: Text(
              country.name,
              style: textStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
