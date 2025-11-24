import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klanetmarketers/features/auth/presentation/providers/providers.dart';
import 'package:klanetmarketers/features/packages/infrastructure/infraestructure.dart';

final packageRepositoryProvider = Provider<PackageRepositoryImpl>((ref) {
  final accessToken = ref.watch(authProvider).user?.jwt;

  final packageRepository = PackageRepositoryImpl(
    PackageDatasourceImpl(accessToken: accessToken ?? ''),
  );

  return packageRepository;
});
