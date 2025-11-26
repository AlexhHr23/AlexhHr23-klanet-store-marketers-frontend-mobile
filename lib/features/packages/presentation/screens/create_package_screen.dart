import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/packages/presentation/providers/package_form_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';

class CreatePackageScreen extends ConsumerWidget {
  final String country;

  const CreatePackageScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear paquete',
          style: textStyle.titleSmall?.copyWith(color: AppColors.secondary),
        ),
      ),
      body: _PackageForm(country: country),
    );
  }
}

class _PackageForm extends ConsumerWidget {
  final String country;

  _PackageForm({required this.country});

  final types = [
    {'value': '1', 'text': 'Fisico'},
    {'value': '0', 'text': 'Digital'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageFormState = ref.watch(packageFormProvider(country));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Nombre',
            hint: 'Nombre de paquete',
            initialValue: packageFormState.name.value,
            errorMessage: packageFormState.name.errorMessage,
            onChanged: (value) => ref
                .read(packageFormProvider(country).notifier)
                .onNameChanged(value),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Selecciona una moneda',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: packageFormState.type,
                items: types.map((type) {
                  return DropdownMenuItem<String>(
                    value: type['value'],
                    child: Text(
                      type['text']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  ref
                      .read(packageFormProvider(country).notifier)
                      .onSelectTypeChanged(value!);
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Guardar',
              onPressed: () {
                ref
                    .read(packageFormProvider(country).notifier)
                    .onFormSubmit()
                    .then((value) {
                      if (value == 'success') {
                        if (!context.mounted) return;
                        customShowSnackBar(
                          context,
                          message: 'Paquete creado correctamente',
                          res: true,
                        );
                        ref.read(packageFormProvider(country).notifier).reset();
                        context.push('/packages');
                      } else if (value == 'form') {
                        if (!context.mounted) return;
                        customShowSnackBar(
                          context,
                          message: 'Todos los campos son obligatorios',
                          res: false,
                        );
                        return;
                      } else if (value == 'error') {
                        if (!context.mounted) return;
                        customShowSnackBar(
                          context,
                          message: 'Error al crear paquete',
                          res: false,
                        );
                      }
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
