import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';

import 's3_service.dart';

class S3ServiceImpl extends S3Service {
  final Dio dio;

  S3ServiceImpl({Dio? dio}) : dio = dio ?? Dio();
  @override
  Future<String> requestSignedUrl(Map<String, dynamic> params) async {
    final apiFaas = Environment.faas;
    final apiKeyFaas = Environment.faasApiKey;

    final url = '$apiFaas/request-signed-url';

    final response = await dio.post(
      url,
      data: params,
      options: Options(
        headers: {
          // 'Authorization': 'Bearer $accessToken',
          'x-api-key': apiKeyFaas,
        },
      ),
    );

    if (response.data is Map<String, dynamic>) {
      final map = response.data as Map<String, dynamic>;

      if (map['data'] != null) {
        return map['data'].toString();
      }
    }

    return response.data.toString();
  }

  @override
  Future<void> uploadFile(String url, List<int> bytes, String mime) async {
    await dio.put(
      url,
      data: Stream.fromIterable([bytes]),
      options: Options(
        headers: {
          'Content-Type': mime,
          // 'x-amz-acl': 'public-read', // si tu backend lo permite
        },
      ),
    );
  }
}
