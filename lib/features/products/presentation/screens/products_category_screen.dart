import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/products/presentation/providers/products_category_provider.dart';
import 'package:klanetmarketers/features/products/presentation/widgets/card_product.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';

class ProductsCategoryScreen extends StatelessWidget {
  final String country;
  final String categoryId;
  const ProductsCategoryScreen({
    super.key,
    required this.country,
    required this.categoryId,
  });
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: _CategoriesView(
        country: country,
        categoryId: int.parse(categoryId),
      ),
    );
  }
}

class _CategoriesView extends ConsumerWidget {
  final String country;
  final int categoryId;
  const _CategoriesView({required this.country, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(
      productsCategoryProvider((categoryId: categoryId, country: country)),
    );

    if (productsState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (productsState.products.isEmpty) {
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
              'No hay productos en esta categoría',
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
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        itemCount: productsState.products.length,
        itemBuilder: (context, index) {
          final product = productsState.products[index];
          return GestureDetector(
            child: ProductCard(product: product, link: productsState.link),
          );
        },
      ),
    );
  }
}
