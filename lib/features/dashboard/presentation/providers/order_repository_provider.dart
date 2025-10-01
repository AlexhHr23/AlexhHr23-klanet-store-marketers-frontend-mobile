import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/providers.dart';
import 'package:klanetmarketers/features/dashboard/infrastructure/infrastructure.dart';

final dashboardRepositoryProvider = Provider<DashboardRepositoryImpl>((ref) {
  final accessToken = ref.watch(authProvider).user?.jwt;

  final dashboardRepository = DashboardRepositoryImpl(
    DashboardDatasourceImpl(accessToken: accessToken ?? ''),
  );

  return dashboardRepository;
});
