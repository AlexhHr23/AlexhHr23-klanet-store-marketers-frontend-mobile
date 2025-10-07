import 'package:klanetmarketers/features/auth/domain/entities/entities.dart';

abstract class AuthRepository {
  Future<void> register();
  Future<AuthZitadel> zitadelAuth();
  Future<User> getUser(String accessToken);
  Future<void> logout(String accessToken);
}
