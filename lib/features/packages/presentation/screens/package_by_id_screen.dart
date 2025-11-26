import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/packages/presentation/providers/providers.dart';
import 'package:klanetmarketers/features/packages/presentation/widgets/card_product_package.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';
import 'package:klanetmarketers/features/shared/widgets/custom_floating_action_button.dart';

class PackageByIdScreen extends StatelessWidget {
  final String country;
  final String packageId;
  const PackageByIdScreen({
    super.key,
    required this.country,
    required this.packageId,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: _ProductsView(country, packageId),
      floatingActionButton: [
        CustomFloatingButton(
          iconData: Icons.add,
          onPressed: () => {},
          heroTag: 'add-product',
          color: AppColors.primary,
        ),
      ],
    );
  }
}

class _ProductsView extends ConsumerStatefulWidget {
  final String country;
  final String packageId;
  const _ProductsView(this.country, this.packageId);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<_ProductsView> {
  final ScrollController scrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   scrollController.addListener(() {
  //     if( (scrollController.position.pixels + 400) >= scrollController.position.maxScrollExtent );
  //     ref.read(productsProvider.notifier).loadNextPage();
  //   });
  //   ref.read(productsProvider.notifier).loadNextPage();
  // }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final packageState = ref.watch(
      getPackageProvider((widget.country, int.parse(widget.packageId))),
    );

    if (packageState.isLoading) {
      return Center(child: const CircularProgressIndicator());
    }

    if (packageState.package!.productos.isEmpty) {
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
              'No hay productos en esta tienda',
              style: TextStyle(color: AppColors.astroGray),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        itemCount: packageState.products.length,
        itemBuilder: (context, index) {
          final product = packageState.products;
          return CardProductPackage(
            product: product[index],
            country: widget.country,
          );
        },
      ),
    );
  }
}
