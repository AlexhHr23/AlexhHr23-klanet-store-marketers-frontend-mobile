import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/dashboard/presentation/presentation.dart';

class BannerSlider extends ConsumerWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banners = ref.watch(dashboardProvider).banners;
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: banners.isNotEmpty
          ? Swiper(
              viewportFraction: 0.9,
              scale: 0.9,
              autoplay: true,
              pagination: SwiperPagination(
                margin: const EdgeInsets.only(top: 0),
                builder: DotSwiperPaginationBuilder(
                  activeColor: colors.primary,
                  color: colors.secondary,
                ),
              ),
              itemCount: banners.length,
              itemBuilder: (context, index) => _Slide(banner: banners[index]),
            )
          : SizedBox(),
    );
  }
}

class _Slide extends StatelessWidget {
  final String banner;

  const _Slide({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // Otras decoraciones si las necesitas
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            banner,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }
              return FadeIn(child: child);
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://onlyflutter.com/wp-content/uploads/2024/03/flutter_banner_onlyflutter-1024x576.png',
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}
