import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';
import 'package:klanetmarketers/features/shared/widgets/custom_floating_action_button.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/products_store_provider.dart';
import 'package:klanetmarketers/features/stores/presentation/widgets/widgets.dart';
// import 'package:teslo_app/features/products/presentation/providers/providers.dart';
// import 'package:teslo_app/features/products/presentation/widgets/widgets.dart';
// import 'package:teslo_app/features/shared/widgets/side_menu.dart';

class ProductsStoreScreen extends StatelessWidget {
  final String country;
  final String storeId;
  const ProductsStoreScreen({
    super.key,
    required this.country,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return AppLayout(
      scaffoldKey: scaffoldKey,
      body: _ProductsView(country, storeId),
      floatingActionButton: [
        CustomFloatingButton(
          iconData: Icons.add, 
          onPressed: () => {},
          heroTag: 'add-product', 
          color: AppColors.primary
        )
      ],
    );
  }
}

class _ProductsView extends ConsumerStatefulWidget {
  final String country;
  final String storeId;
  const _ProductsView(this.country, this.storeId);

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
    final productsState = ref.watch(
      productsStoreProvider((widget.country, int.parse(widget.storeId))),
    );

    if (productsState.isLoading) {
      return Center(child: const CircularProgressIndicator());
    }

    if(productsState.products.isEmpty){
      return const Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.production_quantity_limits_rounded, color: AppColors.astroGray, size: 100),
          SizedBox(height: 10),
          Text('No hay productos en esta tienda', style: TextStyle(color: AppColors.astroGray)),
        ],
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        itemCount: productsState.products.length,
        itemBuilder: (context, index) {
          final product = productsState.products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}
