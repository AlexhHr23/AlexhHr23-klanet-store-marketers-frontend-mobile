import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';

import '../../../shared/domain/entities/entities.dart';

class ProductCard extends ConsumerWidget {
  final Producto product;

  const ProductCard({super.key, required this.product});

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(backgroundColor: Colors.green, content: Text('Producto eliminado correctamentes', style: TextStyle(color: Colors.white)),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        onTap: () {
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.favorite, color: AppColors.danger),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Icon(Icons.more_vert, color: AppColors.astroGray),
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
