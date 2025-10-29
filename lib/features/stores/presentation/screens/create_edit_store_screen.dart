import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/config/utils/app_colors.dart';
import 'package:klanetmarketers/features/shared/providers/currency_provider.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';
import 'package:klanetmarketers/features/stores/presentation/providers/store_provider.dart';

class CreateEditAddresScreen extends ConsumerWidget {
  // final int addressId;
  // final String userId;

  const CreateEditAddresScreen({
    super.key,
    // required this.addressId,
    // required this.userId,
  });

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Direccion Actualizada')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Crear/Editar direccion', style: textStyle.titleSmall?.copyWith(color: AppColors.secondary))),
      body: _AddressForm(),
    );
  }
}

class _AddressForm extends ConsumerWidget {
  // final Address address;
  // final TextEditingController _cityController = TextEditingController();

  // _AddressForm({
  //   required this.address,
  // });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyState = ref.watch(currencyProvider);
    final storeState = ref.watch(storeProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          CustomTextFormField(label: 'Nombre', hint: 'Nombre de la tienda'),
          const SizedBox(height: 16),
          CustomTextFormField(label: 'Descripcion', hint: 'Descripción'),
          const SizedBox(height: 16),
          CustomTextFormField(label: 'Descripcion', hint: 'Descripción'),
          const SizedBox(height: 16),
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
                  value:storeState.selectCurrecy,
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
                      ref.read(storeProvider. notifier).selectCurrency(value);
                    }
                  },
                ),
              ),
            ),
            CustomFilledButton(text: "Guardar")
        ],
      ),
    );
  }
}
