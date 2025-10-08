import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/stores/domain/domain.dart';
import 'package:klanetmarketers/features/stores/infrastructure/mappers/mappers.dart';

class StoresDatasourceImpl extends StoresDatasource {
  final String accessToken;
  late final Dio dio;

  StoresDatasourceImpl({required this.accessToken})
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
  Future<List<MarketerStore>> getStores(String country) async {
    try {
      final response = await dio.get('/stores/$country');
      final stores = <MarketerStore>[];
      for (final store in response.data['zdata']) {
        stores.add(MarketerStoreMapper.jsonToEntity(store));
      }
      return stores;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        throw Exception('Error al obtener los paises');
      }
      throw Exception('Error al obtener los paises');
    } catch (e) {
      // print('Error no controlado: $e');
      throw Exception(e);
    }
  }

  @override
  Future<void> getBannersByStore(String country, String id) {
    // TODO: implement getBannersByStore
    throw UnimplementedError();
  }

  @override
  Future<void> getProductsByStore(String country, String id) {
    // TODO: implement getProductsByStore
    throw UnimplementedError();
  }
}
