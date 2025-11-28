import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/auth_provider.dart';
import 'package:klanetmarketers/features/commissions/infrastructure/datasources/commission_datasource_impl.dart';
import 'package:klanetmarketers/features/commissions/infrastructure/repositories/commissions_repository_impl.dart';

final commissionRepositoryProvider = Provider<CommissionsRepositoryImpl>((ref) {
  final accessToken = ref.watch(authProvider).user?.jwt;

  final productsRepository = CommissionsRepositoryImpl(
    CommissionDatasourceImpl(accessToken: accessToken ?? ''),
  );

  return productsRepository;
});
