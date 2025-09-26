class AuthZitadel {
  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final int expiresIn;
  final String tokenId;

  AuthZitadel({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
    required this.tokenId,
  });

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_id': tokenId,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'token_type': tokenType,
    };
  }

  factory AuthZitadel.fromJson(Map<String, dynamic> json) {
    return AuthZitadel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      refreshToken: json['refresh_token'],
      tokenId: json['token_id'],
      expiresIn: json['expires_in'],
    );
  }
}
