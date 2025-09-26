import 'package:klanetmarketers/features/auth/domain/datasources/auth_datasource.dart';
import 'package:klanetmarketers/features/auth/domain/repositories/auth_repository.dart';
import 'package:klanetmarketers/features/auth/infrastructure/datasources/auth_datasource_impl.dart';

import '../../domain/entities/entities.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({AuthDatasource? datasource})
    : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<void> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(String accessToken) {
    return datasource.getUser(accessToken);
  }

  @override
  Future<AuthZitadel> zitadelAuth() {
    return datasource.authZitadel();
  }

  @override
  Future<void> logout(String accessToken) {
    return datasource.logout(accessToken);
  }
}
