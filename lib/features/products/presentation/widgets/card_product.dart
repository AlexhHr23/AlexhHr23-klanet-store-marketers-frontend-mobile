import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';
import 'package:klanetmarketers/features/products/presentation/providers/products_category_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared/domain/entities/entities.dart';

class ProductCard extends ConsumerWidget {
  final Producto product;
  final String link;
  final String country;
  final int categoryId;

  const ProductCard({super.key, required this.product, required this.link, required this.country, required this.categoryId});

  void showSnackBarProdct(BuildContext context, String message, bool response) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: response ? Colors.green : Colors.red,
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final authState = ref.watch(authProvider);
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
                child: _ContentSection(product: product, textStyle: textStyle),
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
        // product.esFavorito == 1 ? Container() :
        Positioned(
          top: 12,
          left: 12,
          child: GestureDetector(
            onTap:product.esFavorito == 0 ? () async{
              final res = await ref.read(productsCategoryProvider((country: country, categoryId: categoryId,)).notifier).addProductToFavorite(product.id);
              customShowSnackBar(context, message: res ? 'Producto agregado a favoritos' : 'Hubo un error al agregar', res: res);
            } : null,
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
            onSelected: (value) async {
              if (value == 'share') {
                final params = ShareParams(
                  uri: Uri.parse(
                    '$link/products/${product.padre.id}/${product.slug}?code=${authState.user?.profile.sellerCode}&moneda=${product.moneda}&product=${product.id}',
                  ),
                );
                await SharePlus.instance.share(params);
              } else if (value == 'copy') {
                final params = ShareParams(
                  uri: Uri.parse(
                    '$link/checkout-fast?${product.padre.tipo?.esFisico == '1' ? 'type=products' : 'type=digitals'}&product=${product.id}&code=${authState.user?.profile.sellerCode}&moneda=${product.moneda}',
                  ),
                );
                await SharePlus.instance.share(params);
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

class _ContentSection extends StatelessWidget {
  final Producto product;
  final TextTheme textStyle;

  const _ContentSection({required this.product, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre del producto
          Text(
            product.padre.nombre,
            style: textStyle.bodySmall?.copyWith(fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Text(
            'Marca: ${product.padre.marca.nombre}',
            style: textStyle.bodySmall?.copyWith(fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          // Precio
          Text(
            '\$${product.precioDescuento.toStringAsFixed(2)} ${product.moneda}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                height: 25,
                child: CustomFilledButton(
                  text: 'Tienda',
                  textStyle: textStyle.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  buttonColor: AppColors.primary,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                height: 25,
                child: CustomFilledButton(
                  text: 'Paquete',
                  textStyle: textStyle.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  buttonColor: AppColors.primary,
                  onPressed: () {},
                ),
              ),
            ],
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
