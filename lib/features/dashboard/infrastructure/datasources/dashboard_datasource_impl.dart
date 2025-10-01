import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/dashboard/domain/domain.dart';

import '../mappers/mappers.dart';

class DashboardDatasourceImpl extends DashboardDatasource {
  late final Dio dio;
  final String accessToken;

  DashboardDatasourceImpl({required this.accessToken})
    : dio = Dio(
        BaseOptions(
          baseUrl: Environment.baseUrlMarket,
          headers: {
            'x-api-key': Environment.fireclubKey,
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
  @override
  Future<Balance> getTimeZones() async {
    try {
      final response = await dio.get('/select/time-zones');
      final balance = BalanceMapper.jsonToEntity(response.data);
      return balance;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        throw Exception('Error al obtener las zonas horarias');
      }
      throw Exception('Error al obtener las zonas horarias');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
