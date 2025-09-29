import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:app_links/app_links.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
// import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/auth/domain/datasources/auth_datasource.dart';
import 'package:klanetmarketers/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/entities.dart';
import '../mappers/mappers.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final zitadelClientId = Environment.cliendId;
  final callbackScheme = Environment.callback;
  final zitadelIssuer = Uri.parse(Environment.issuer);

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.baseUrlPublic,
      headers: {'x-api-key': Environment.fireclubKey},
    ),
  );

  @override
  Future<void> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<AuthZitadel> authZitadel() async {
    final codeVerifier = _generateCodeVerifier();
    final codeChallenge = _generateCodeChallenge(codeVerifier);

    // print('🔑 Code Verifier: $codeVerifier');
    print('🔑 Code Challenge: $codeChallenge');

    final redirectUri = '$callbackScheme:/callback';

    final authUrl = Uri.https(zitadelIssuer.authority, '/oauth/v2/authorize', {
      'response_type': 'code',
      'client_id': zitadelClientId,
      'redirect_uri': redirectUri,
      'scope': 'openid profile email offline_access',
      'code_challenge': codeChallenge,
      'code_challenge_method': 'S256',
    }).toString();

    print('🔗 Auth URL: $authUrl');
    print('🔄 Redirect URI: $redirectUri');

    final completer = Completer<AuthZitadel>();
    final appLinks = AppLinks();
    StreamSubscription<Uri>? sub; // 👈 declaramos aquí

    try {
      // Lanzar navegador externo
      if (!await launchUrl(
        Uri.parse(authUrl),
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('No se pudo abrir el navegador');
      }

      // Escuchar el callback
      sub = appLinks.uriLinkStream.listen((Uri? uri) async {
        if (uri != null && uri.toString().startsWith(redirectUri)) {
          print('✅ Redirect recibido: $uri');
          final code = uri.queryParameters['code'];

          if (code != null) {
            try {
              final tokenUrl = Uri.https(
                zitadelIssuer.authority,
                '/oauth/v2/token',
              );
              print('🌐 Token URL: $tokenUrl');

              final response = await dio.post(
                tokenUrl.toString(),
                data: {
                  'client_id': zitadelClientId,
                  'redirect_uri': redirectUri,
                  'grant_type': 'authorization_code',
                  'code': code,
                  'code_verifier': codeVerifier,
                },
                options: Options(
                  headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                  },
                ),
              );

              if (response.statusCode == 200) {
                final auth = AuthZitadelMapper.jsonToentity(response.data);
                completer.complete(auth);
              } else {
                completer.completeError(
                  Exception('Error al obtener el token: ${response.data}'),
                );
              }
            } catch (e) {
              completer.completeError(e);
            } finally {
              await sub?.cancel(); // 👈 se cancela de forma segura
            }
          } else {
            final error = uri.queryParameters['error'];
            final errorDescription = uri.queryParameters['error_description'];
            completer.completeError(
              Exception('Error en autenticación: $error - $errorDescription'),
            );
            await sub?.cancel();
          }
        }
      });
    } catch (e) {
      print('❌ Error detallado:');
      print('   - Tipo: ${e.runtimeType}');
      print('   - Mensaje: $e');
      await sub?.cancel(); // 👈 catch también cancela
      rethrow;
    }

    return completer.future;
  }

  String _generateCodeVerifier() {
    final random = Random.secure();
    return base64UrlEncode(
      List<int>.generate(32, (_) => random.nextInt(256)),
    ).replaceAll('=', '').replaceAll('+', '-').replaceAll('/', '_');
  }

  String _generateCodeChallenge(String codeVerifier) {
    final bytes = utf8.encode(codeVerifier);
    return base64UrlEncode(
      sha256.convert(bytes).bytes,
    ).replaceAll('=', '').replaceAll('+', '-').replaceAll('/', '_');
  }

  @override
  Future<User> getUser(String accessToken) async {
    try {
      final response = await dio.get(
        '/user',
        options: Options(
          headers: {
            'x-api-key': Environment.fireclubKey,
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      final user = UserMapper.jsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['error'] ?? 'Token invalido');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexion a interet');
      }
      throw Exception();
    } catch (e) {
      throw 'Error no controlado';
    }
  }

  @override
  Future<void> logout(String idToken) async {
    final logoutUrl =
        Uri.https(zitadelIssuer.authority, '/oidc/v1/end_session', {
          'id_token_hint': idToken,
          'post_logout_redirect_uri': '$callbackScheme:/',
          'state': 'random_string',
        });

    try {
      final launched = await launchUrl(
        logoutUrl,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception('No se pudo abrir el navegador para logout');
      }

      print('Logout iniciado en ZITADEL');
    } catch (e) {
      print('Error durante el logout: $e');
      throw Exception('Error al realizar el logout de ZITADEL');
    }
  }
}
