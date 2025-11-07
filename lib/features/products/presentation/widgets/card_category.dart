import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/products/domain/domain.dart';

class CardCategory extends ConsumerWidget {
  final String country;
  final CategoryProduct category;

  const CardCategory({super.key, required this.category, required this.country});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    return FadeInUp(
      animate: true,
      child: SizedBox(
        height: 200,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               _ImageViewer(imageUrl: category.imagen),
               SizedBox(height: 10,),
               Text(
                  category.nombre,
                  style: textStyle.bodySmall,
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
          height: 150,
        ),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 150,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Image.asset(
            'assets/images/bottle-loader.gif',
            fit: BoxFit.cover,
            height: 150,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/no-image.jpg',
            fit: BoxFit.cover,
            height: 150,
          );
        },
      ),
    );
  }
}
