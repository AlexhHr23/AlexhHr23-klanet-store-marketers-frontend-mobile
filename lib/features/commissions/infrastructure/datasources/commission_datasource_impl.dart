import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/commissions/domain/domain.dart';
import 'package:klanetmarketers/features/commissions/infrastructure/mappers/mappers.dart';

class CommissionDatasourceImpl extends CommissionDatasource {
  final String accessToken;
  late Dio dio;

  CommissionDatasourceImpl({required this.accessToken})
    : dio = Dio(
        BaseOptions(
          baseUrl: Environment.baseUrlMarket,
          headers: {
            'x-api-key': Environment.fireclubKey,
            'Authorization': 'Bearer $accessToken'
          },
        ),
      );

  @override
  Future<List<NetworkCommission>> getNetworkCommissions(String date) async{
     try {
      final response = await dio.get('/commissions/direct-recomentation-all?fecha=$date');
      final commissions = <NetworkCommission>[];
      for (final commission in response.data['data'] ?? []) {
        commissions.add(NetworkCommissionMapper.jsonToEntity(commission));
      }
      return commissions;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        throw Exception('Error al obtener las comisiones');
      }
      throw Exception('Error al obtener las comisiones');
    } catch (e) {
      // print('Error no controlado: $e');
      throw Exception(e);
    }
  }
}
