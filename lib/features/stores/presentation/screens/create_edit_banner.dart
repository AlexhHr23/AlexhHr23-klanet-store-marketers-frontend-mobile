import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/shared/providers/currency_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_form_provider.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider.dart';

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
          'Crear/Editar direccion',
          style: textStyle.titleSmall?.copyWith(color: AppColors.secondary),
        ),
      ),
      body: _AddressForm(),
    );
  }
}

class _AddressForm extends ConsumerWidget {
  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Producto actualizado')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyState = ref.watch(currencyProvider);
    final storeState = ref.watch(storeProvider);

    if (storeState.selectedStore == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final storeFormState = ref.watch(
      storeFormProvider(storeState.selectedStore!),
    );


    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Nombre',
            hint: 'Nombre de la tienda',
            initialValue: storeFormState.name.value,
            errorMessage: storeFormState.name.errorMessage,
            onChanged: (value) => ref
                .read(storeFormProvider(storeState.selectedStore!).notifier)
                .onNameChanged(value),
          ),
          const SizedBox(height: 20),
          CustomTextArea(
            label: 'Descripcion',
            hint: 'Descripción',
            initialValue: storeFormState.description.value,
            errorMessage: storeFormState.description.errorMessage,
            onChanged: (value) => ref
                .read(storeFormProvider(storeState.selectedStore!).notifier)
                .onDescChanged(value),
          ),
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
                value: storeFormState.currency,
                items: currencyState.currencies.map((country) {
                  return DropdownMenuItem<String>(
                    value: country.code,
                    child: Text(
                      country.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  print('value: $value');
                  ref.read(storeFormProvider(storeState.selectedStore!).notifier).onSelectCurrencyChanged(value!);
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
                    .read(storeFormProvider(storeState.selectedStore!).notifier)
                    .onFormSubmit()
                    .then((value) {
                      if (!value) return;
                      showSnackBar(context);
                      context.push('/stores');
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
