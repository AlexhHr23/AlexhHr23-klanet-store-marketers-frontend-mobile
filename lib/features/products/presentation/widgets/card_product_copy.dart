import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared/domain/entities/entities.dart';

class ProductCardCopy extends ConsumerWidget {
  final Producto product;
  final String link;

  const ProductCardCopy({super.key, required this.product, required this.link});

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Producto eliminado correctamentes',
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
      child: SizedBox(
        height: 300,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Stack(
                  children: [
                    _ImageViewer(imageUrl: product.fotos[0].archivo),
                    Positioned(
                      top: 8,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            product.esFavorito == 1
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppColors.danger,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          showMenu(
                            context: context,
                            position: const RelativeRect.fromLTRB(
                              1000,
                              80,
                              10,
                              0,
                            ),
                            items: [
                              PopupMenuItem(
                                value: 'share',
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.send,
                                      color: AppColors.primary,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text('Obtener enlace'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'copy',
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.link,
                                      color: AppColors.primary,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text('Enlace compra rapida'),
                                  ],
                                ),
                              ),
                            ],
                          ).then((value) async {
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
                          });
                        },
                        child: const Icon(
                          Icons.share,
                          color: AppColors.astroGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.padre.nombre,
                  style: textStyle.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '\$${product.precioDescuento.toStringAsFixed(2)}${product.moneda}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                child: CustomFilledButton(
                  text: 'Comprar',
                  textStyle: textStyle.bodySmall?.copyWith(color: Colors.white),
                  buttonColor: AppColors.primary,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final String imageUrl;

  const _ImageViewer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);

    if (imageUrl.isEmpty) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          'assets/images/no-image.jpg',
          fit: BoxFit.cover,
          height: 250,
        ),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 250,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Image.asset(
            'assets/images/bottle-loader.gif',
            fit: BoxFit.cover,
            height: 250,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/no-image.jpg',
            fit: BoxFit.cover,
            height: 250,
          );
        },
      ),
    );
  }
}
