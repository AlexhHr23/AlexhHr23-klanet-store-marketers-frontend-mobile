import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/shared/widgets/widgets.dart';

class CreateEditAddresScreen extends ConsumerWidget {
  final int addressId;
  final String userId;

  const CreateEditAddresScreen({
    super.key,
    required this.addressId,
    required this.userId,
  });

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Direccion Actualizada')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create/Edit Address')),
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
          CustomTextFormField(label: 'Facebook pixel', hint: 'Facebook pixel'),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Google analytics',
            hint: 'Google analytics',
          ),
          const SizedBox(height: 16),
          CustomTextFormField(label: 'MS clarity', hint: 'MS clarity'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
