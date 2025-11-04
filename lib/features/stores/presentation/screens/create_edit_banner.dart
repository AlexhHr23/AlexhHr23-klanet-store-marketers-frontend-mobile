import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/shared/infrastructure/services/camera_gallery_service_impl.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/banner_form_provider.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_banners_provider.dart';

class CreateEditBanner extends ConsumerWidget {
  final String country;
  final String storeId;
  const CreateEditBanner({
    required this.country,
    required this.storeId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear/Editar banner',
          style: textStyle.titleSmall?.copyWith(color: AppColors.secondary),
        ),
      ),
      body: _BannerForm(country: country, storeId: int.parse(storeId)),
    );
  }
}

class _BannerForm extends ConsumerWidget {
  final String country;
  final int storeId;

  const _BannerForm({required this.country, required this.storeId});

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Banner actualiazo')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerState = ref
        .watch(bannersStoreProvider((country, storeId)))
        .selectedBanner;
    final bannerFormState = ref.watch(
      bannerFormProvider((
        banner: bannerState!,
        country: country,
        storeId: storeId,
      )),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ImageGallery(image: bannerFormState.fileImage.value),
          IconButton(
            onPressed: () async {
              final photoPath = await CameraGalleryServiceImpl().selectPhto();
              if (photoPath == null) return;
              ref
                  .read(
                    bannerFormProvider(((
                      banner: bannerState,
                      country: country,
                      storeId: storeId,
                    ))).notifier,
                  )
                  .onSelectBannerChanged(photoPath);
            },
            icon: const Icon(Icons.add_a_photo),
          ),
          const SizedBox(height: 20),
          _ImageGallery(image: bannerFormState.fileImageMobile.value),
          IconButton(
            onPressed: () async {
              final photoPath = await CameraGalleryServiceImpl().selectPhto();
              if (photoPath == null) return;
              ref
                  .read(
                    bannerFormProvider(((
                      banner: bannerState,
                      country: country,
                      storeId: storeId,
                    ))).notifier,
                  )
                  .onSelectBannerMobileChanged(photoPath);
            },
            icon: const Icon(Icons.add_a_photo),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Titulo',
            hint: 'Titulo',
            initialValue: bannerFormState.text.value,
            errorMessage: bannerFormState.text.errorMessage,
            onChanged: (value) => {
              ref
                  .read(
                    bannerFormProvider(((
                      banner: bannerState,
                      country: country,
                      storeId: storeId,
                    ))).notifier,
                  )
                  .onTitleChanged(value),
            },
          ),
          const SizedBox(height: 20),
          CustomNumericFormField(
            label: 'Duración (seg)',
            hint: 'Ingresa valor',
            allowDecimal: false,
            initialValue: bannerFormState.duration.value,
            errorMessage: bannerFormState.duration.errorMessage,
            onChanged:  (value) => {
              ref
                  .read(
                    bannerFormProvider(((
                      banner: bannerState,
                      country: country,
                      storeId: storeId,
                    ))).notifier,
                  )
                  .onDurationChanged(int.parse(value)),
            },
          ),
          SizedBox(height: 20),
           CustomNumericFormField(
            label: 'Orden',
            hint: 'Ingresa valor',
            initialValue: bannerFormState.order.value,
            allowDecimal: false,
            errorMessage: bannerFormState.order.errorMessage,
            onChanged:  (value) => {
              ref
                  .read(
                    bannerFormProvider(((
                      banner: bannerState,
                      country: country,
                      storeId: storeId,
                    ))).notifier,
                  )
                  .onOrderChanged(int.parse(value)),
            },
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Guardar',
              onPressed: () {
                  ref
                  .read(
                    bannerFormProvider(((
                      banner: bannerState,
                      country: country,
                      storeId: storeId,
                    ))).notifier,
                  )
                    .onFormSubmit()
                    .then((value) {
                      if (!value) return;
                      showSnackBar(context);
                      context.push('/stores/banners/$storeId?country=$country');
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  final String image;
  const _ImageGallery({required this.image});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);

    if (image.isEmpty) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          'assets/images/no-image.jpg',
          fit: BoxFit.cover,
          height: 100,
          width: 200,
        ),
      );
    }

    late ImageProvider imageProvider;
    if (image.startsWith('http')) {
      imageProvider = NetworkImage(image);
    } else {
      imageProvider = FileImage(File(image));
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: FadeInImage(
        fit: BoxFit.cover,
        image: imageProvider,
        placeholder: const AssetImage('assets/images/bottle-loader.gif'),
      ),
    );
  }
}
