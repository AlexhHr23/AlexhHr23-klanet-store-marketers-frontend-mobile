import '../../domain/entities/entities.dart';

class AuthZitadelMapper {
  static AuthZitadel jsonToentity(Map<String, dynamic> json) => AuthZitadel(
    accessToken: json['access_token'] ?? '',
    tokenType: json['token_type'] ?? '',
    refreshToken: json['refresh_token'] ?? '',
    expiresIn: json['expires_in'] ?? 0,
    tokenId: json['id_token'] ?? '',
  );
}
