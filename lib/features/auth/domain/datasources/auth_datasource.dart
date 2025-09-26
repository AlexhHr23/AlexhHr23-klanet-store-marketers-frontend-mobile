import '../entities/entities.dart';

abstract class AuthDatasource {
  Future<void> register();
  Future<AuthZitadel> authZitadel();
  Future<User> getUser(String accessToken);
  Future<void> logout(String accessToken);
}
