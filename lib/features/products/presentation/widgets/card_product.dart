import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';
import 'package:klanetmarketers/features/packages/domain/domain.dart';
import 'package:klanetmarketers/features/packages/presentation/providers/get_packages_provider.dart';
import 'package:klanetmarketers/features/products/presentation/providers/products_category_provider.dart';
import 'package:klanetmarketers/features/shared/providers/currency_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';
import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/get_stores_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared/domain/entities/entities.dart';

class ProductCard extends ConsumerWidget {
  final Producto product;
  final String link;
  final String country;
  final int categoryId;

  const ProductCard({
    super.key,
    required this.product,
    required this.link,
    required this.country,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final authState = ref.watch(authProvider);
    final storesState = ref.watch(getStoreProvider(country)).stores;
    final packagesState = ref.watch(getPackagesProvider(country));

    return FadeInUp(
      animate: true,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: 150,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: _ImageSection(
                  product: product,
                  link: link,
                  authState: authState,
                  country: country,
                  categoryId: categoryId,
                ),
              ),

              // Contenido a la derecha
              Expanded(
                flex: 3,
                child: _ContentSection(
                  product: product,
                  textStyle: textStyle,
                  country: country,
                  storesState: storesState,
                  packageState: product.padre.tipo?.esFisico == '1'
                      ? packagesState.physicalPackages
                      : packagesState.digitalPackages,
                  productId: product.id,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageSection extends ConsumerWidget {
  final Producto product;
  final String link;
  final String country;
  final int categoryId;
  final AuthState authState;

  const _ImageSection({
    required this.product,
    required this.link,
    required this.country,
    required this.categoryId,
    required this.authState,
  });

  void openDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Borrar de favoritos'),
        content: const Text('¿Estas seguro de borrar de favoritos?'),
        actions: [
          TextButton(
            onPressed: () {
              ref
                  .read(
                    productsCategoryProvider((
                      country: country,
                      categoryId: categoryId,
                    )).notifier,
                  )
                  .deleteProductFromFavorite(product.id);
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

  void _showCurrencySelection(
    BuildContext context,
    WidgetRef ref,
    bool isFastBuy,
  ) {
    final currenciesState = ref.watch(currencyProvider).currencies;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isFastBuy
                  ? 'Selecciona moneda para compra rápida'
                  : 'Selecciona moneda para enlace',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...currenciesState.map(
              (currency) => ListTile(
                leading: const Icon(
                  Icons.currency_exchange,
                  color: AppColors.primary,
                ),
                title: Text(currency.name),
                onTap: () {
                  Navigator.pop(context);
                  _shareLink(context, currency.code.toString(), isFastBuy);
                },
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }

  void _shareLink(
    BuildContext context,
    String currencyId,
    bool isFastBuy,
  ) async {
    final shareUri = isFastBuy
        ? Uri.parse(
            '$link/checkout-fast?${product.padre.tipo?.esFisico == '1' ? 'type=products' : 'type=digitals'}&product=${product.id}&code=${authState.user?.profile.sellerCode}&moneda=$currencyId',
          )
        : Uri.parse(
            '$link/products/${product.padre.id}/${product.slug}?code=${authState.user?.profile.sellerCode}&moneda=$currencyId&product=${product.id}',
          );

    final params = ShareParams(uri: shareUri);
    await SharePlus.instance.share(params);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        // Imagen del producto
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _ImageViewer(imageUrl: product.fotos[0].archivo),
          ),
        ),

        // Botón de favorito (esquina superior izquierda)
        Positioned(
          top: 12,
          left: 12,
          child: GestureDetector(
            onTap: product.esFavorito == 0
                ? () async {
                    final res = await ref
                        .read(
                          productsCategoryProvider((
                            country: country,
                            categoryId: categoryId,
                          )).notifier,
                        )
                        .addProductToFavorite(product.id);
                    if (!context.mounted) return;
                    customShowSnackBar(
                      context,
                      message: res
                          ? 'Producto agregado a favoritos'
                          : 'Hubo un error al agregar',
                      res: res,
                    );
                  }
                : () => showCustomDialog(
                    title: 'Eliminar producto',
                    desc: '¿Desea eliminar el producto de favoritos?',
                    type: DialogType.question,
                    context: context,
                    onOkPress: () async {
                      final res = await ref
                          .read(
                            productsCategoryProvider((
                              country: country,
                              categoryId: categoryId,
                            )).notifier,
                          )
                          .deleteProductFromFavorite(product.id);

                      if (res) {
                        if (!context.mounted) return;
                        customShowSnackBar(
                          context,
                          message: res
                              ? 'Producto eliminado de favoritos'
                              : 'Hubo un error al eliminar',
                          res: res,
                        );
                      }
                    },
                  ).show(),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Icon(
                product.esFavorito == 1
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: AppColors.danger,
                size: 16,
              ),
            ),
          ),
        ),

        // Botón de compartir (esquina superior derecha) - CON POPUPMENUBUTTON
        Positioned(
          top: 12,
          right: 12,
          child: PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            offset: const Offset(0, 10),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: const [
                    Icon(Icons.send, color: AppColors.primary, size: 18),
                    SizedBox(width: 8),
                    Text('Obtener enlace'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'copy',
                child: Row(
                  children: const [
                    Icon(Icons.link, color: AppColors.primary, size: 18),
                    SizedBox(width: 8),
                    Text('Enlace compra rápida'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'share') {
                _showCurrencySelection(context, ref, false);
              } else if (value == 'copy') {
                _showCurrencySelection(context, ref, true);
              }
            },
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.share,
                color: AppColors.astroGray,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContentSection extends ConsumerWidget {
  final Producto product;
  final TextTheme textStyle;
  final String country;
  final List<MarketerStore> storesState;
  final List<Package> packageState;
  final int productId;

  const _ContentSection({
    required this.product,
    required this.textStyle,
    required this.country,
    required this.storesState,
    required this.packageState,
    required this.productId,
  });

  void _showStoreSelection(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Selecciona tienda',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...storesState.map(
              (store) => ListTile(
                leading: const Icon(Icons.store, color: AppColors.primary),
                title: Text(store.nombre),
                onTap: () async {
                  Navigator.pop(context);
                  final res = await ref
                      .read(
                        productsCategoryProvider((
                          country: country,
                          categoryId: productId,
                        )).notifier,
                      )
                      .addProductToStore(product.id, store.id);
                  if (!context.mounted) return;
                  customShowSnackBar(
                    context,
                    message: res
                        ? 'Producto agregado a la tienda'
                        : 'Ya existe el producto en la tienda',
                    res: res,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPackageSelection(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Selecciona paquete',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...packageState.map(
              (package) => ListTile(
                leading: const Icon(Icons.store, color: AppColors.primary),
                title: Text(package.nombre),
                onTap: () async {
                  Navigator.pop(context);
                  final res = await ref
                      .read(
                        productsCategoryProvider((
                          country: country,
                          categoryId: productId,
                        )).notifier,
                      )
                      .addProductToPackage(product.id, package.id);
                  if (!context.mounted) return;
                  customShowSnackBar(
                    context,
                    message: res
                        ? 'Producto agregado al paquete'
                        : 'Ya existe el producto en el paquete',
                    res: res,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Nombre del producto
          Text(
            product.padre.nombre,
            style: textStyle.bodySmall?.copyWith(fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Marca: ${product.padre.marca?.nombre}',
                style: textStyle.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 8),
              // Precio
              Text(
                '\$${product.precioDescuento.toStringAsFixed(2)} ${product.moneda}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 25,
            child: CustomFilledButton(
              text: 'Agregar a tienda',
              textStyle: textStyle.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
              buttonColor: AppColors.primary,
              onPressed: () {
                _showStoreSelection(context, ref);
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 25,
            child: CustomFilledButton(
              text: 'Agreagar a paquete',
              textStyle: textStyle.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
              buttonColor: AppColors.primary,
              onPressed: () {
                _showPackageSelection(context, ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final String imageUrl;

  const _ImageViewer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Image.asset(
        'assets/images/no-image.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Image.asset(
          'assets/images/bottle-loader.gif',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/no-image.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      },
    );
  }
}
