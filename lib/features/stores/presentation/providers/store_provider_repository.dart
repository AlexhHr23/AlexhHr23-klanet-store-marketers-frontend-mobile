import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/providers.dart';
import 'package:klanetmarketers/features/stores/infrastructure/datasources/stores_datasource_impl.dart';
import 'package:klanetmarketers/features/stores/infrastructure/repositories/stores_repository_impl.dart';

final storeRepositoryProvider = Provider<StoresRepositoryImpl>((ref) {
  final accessToken = ref.watch(authProvider).user?.jwt;

  final storeRepository = StoresRepositoryImpl(
    StoresDatasourceImpl(accessToken: accessToken ?? ''),
  );

  return storeRepository;
});
