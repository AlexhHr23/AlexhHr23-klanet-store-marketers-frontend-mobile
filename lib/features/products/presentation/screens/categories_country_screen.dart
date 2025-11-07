import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/products/presentation/providers/categories_country_provider.dart';
import 'package:klanetmarketers/features/products/presentation/widgets/card_category.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';
import 'package:klanetmarketers/features/shared/widgets/custom_floating_action_button.dart';

class CategoriesCountryScreen extends StatelessWidget {
  final String country;
  const CategoriesCountryScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: _CategoriesView(country: country),
      floatingActionButton: [
        CustomFloatingButton(
          iconData: Icons.add,
          onPressed: () {},
          heroTag: 'add-product',
          color: AppColors.primary,
        ),
      ],
    );
  }
}

class _CategoriesView extends ConsumerWidget {
  final String country;
  const _CategoriesView({required this.country});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesState = ref.watch(categoriesCountryProvider(country));

    if (categoriesState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (categoriesState.categories.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.production_quantity_limits_rounded,
              color: AppColors.astroGray,
              size: 100,
            ),
            SizedBox(height: 10),
            Text(
              'No hay categorías',
              style: TextStyle(color: AppColors.astroGray),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        itemCount: categoriesState.categories.length,
        itemBuilder: (context, index) {
          final category = categoriesState.categories[index];
          return GestureDetector(
            onTap: () {},
            child: CardCategory(category: category, country: country)
          );
        },
      ),
    );
  }
}
