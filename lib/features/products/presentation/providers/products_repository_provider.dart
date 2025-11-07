// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';
// import 'package:klanetmarketers/features/products/infrastructure/datasources/products_datasources_imp.dart';
// import 'package:klanetmarketers/features/products/infrastructure/repositories/products_repository_impl.dart';
// import 'package:klanetmarketers/features/shared/infrastructure/datasources/currency_datasource_impl.dart';
// import 'package:klanetmarketers/features/shared/infrastructure/repositories/currency_repository_impl.dart';

// final productsRepositoryProvider = Provider<CurrencyRepositoryImpl>((ref) {
//   final accessToken = ref.watch(authProvider).user?.jwt;

//   final productsRepository = ProductsRepositoryImpl(
//     ProductsDatasourcesImp(accessToken: accessToken ?? ''),
//   );

//   return currencyRepository;
// });
