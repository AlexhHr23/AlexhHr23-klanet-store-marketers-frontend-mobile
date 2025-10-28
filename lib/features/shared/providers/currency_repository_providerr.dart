import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/shared/infrastructure/datasources/currency_datasource_impl.dart';
import 'package:klanetmarketers/features/shared/infrastructure/repositories/currency_repository_impl.dart';

import '../../auth/auth.dart';

final currencyRepositoryProvider = Provider<CurrencyRepositoryImpl>((ref) {
  final accessToken = ref.watch(authProvider).user?.jwt;

  final currencyRepository = CurrencyRepositoryImpl(
    CurrencyDatasourceImpl(accessToken: accessToken ?? ''),
  );

  return currencyRepository;
});
