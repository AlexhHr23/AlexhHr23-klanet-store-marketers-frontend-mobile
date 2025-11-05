

import 'package:flutter/material.dart';
import 'package:klanetmarketers/features/shared/layout/app_layout.dart';

class ProductsStoreScreen extends StatelessWidget {
  final String country;
  final String storeId;
  const ProductsStoreScreen({super.key, required this.country, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      body: const Center(child: Text('ProductsStoreScreen')),
    );
  }
}