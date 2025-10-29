import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/shared/providers/currency_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_form_provider.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider.dart';

class CreateEditAddresScreen extends ConsumerWidget {
  // final int addressId;
  // final String userId;

  const CreateEditAddresScreen({
    super.key,
    // required this.addressId,
    // required this.userId,
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

    if (currencyState.currencies.isNotEmpty &&
        storeState.selectCurrecy == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(storeProvider.notifier)
            .selectCurrency(storeFormState.currency);
      });
    }

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
                value: storeState.selectCurrecy,
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
                  if (value != null) {
                    ref.read(storeProvider.notifier).selectCurrency(value);
                  }
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
