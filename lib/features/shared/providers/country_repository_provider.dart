import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/shared/infrastructure/datasources/countries_datasource_impl.dart';
import 'package:klanetmarketers/features/shared/infrastructure/repositories/country_repository_impl.dart';

import '../../auth/auth.dart';

final countryRepositoryProvider = Provider<CountryRepositoryImpl>((ref) {
  final accessToken = ref.watch(authProvider).user?.jwt;

  final dashboardRepository = CountryRepositoryImpl(
    CountriesDatasourceImpl(accessToken: accessToken ?? ''),
  );

  return dashboardRepository;
});
