import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String fireclubKey = dotenv.env['VITE_APIKEY'] ?? 'No hay api key';
  static String baseUrlPublic =
      dotenv.env['VITE_API_URL'] ?? 'No está configurado el API_URL_PUBLIC';
  static String baseUrlMarket =
      dotenv.env['VITE_API_MARKET'] ?? 'No está configurado el API_URL_MARKET';
  static String baseUrlEnvios =
      dotenv.env['VITE_ENVIOSCOM_API_URL'] ??
      'No está configurado el API_URL_ENVIOS';
  static String viteS3 =
      dotenv.env['VITE_S3'] ?? 'No esta configurado el VITE_S3';
  static String cliendId =
      dotenv.env['VITE_ZITADEL_CLIENTID'] ?? 'No esta configurado el CLIENT_ID';
  static String issuer =
      dotenv.env['VITE_ZITADEL_ISSUERURL'] ?? 'No esta configurado el ISSUER';
  static String callback =
      dotenv.env['CALLBACK_URL_SCHEME'] ??
      'No esta configurado el CALLBACK_URL_SCHEME';
}
