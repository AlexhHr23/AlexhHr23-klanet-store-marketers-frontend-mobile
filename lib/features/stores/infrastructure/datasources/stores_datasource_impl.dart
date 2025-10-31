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
  Future<MarketerStore> createUpdateStore(
    Map<String, dynamic> storeLike,
    String country,
  ) async {
    try {
      final int? storeId = storeLike["id"];
      final String method = (storeId == null) ? 'POST' : "PUT";
      final String url = (storeId == null)
          ? '/stores/$country'
          : '/stores/$country/$storeId';

      storeLike.remove('id');
      final response = await dio.request(
        url,
        data: storeLike,
        options: Options(method: method),
      );
      final store = MarketerStoreMapper.jsonToEntity(response.data["data"]);
      return store;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        throw Exception('Error al crear la tienda');
      }
      throw Exception('Error al crear la tienda');
    } catch (error) {
      throw Exception(error);
    }
  }

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
  Future<Map<String, dynamic>> deleteStore(String country, int storeId) async {
    final res = {"status": '', "msg": ''};

    try {
      final response = await dio.delete('/stores/$country/$storeId');

      if (response.data["status"] == 'success') {
        res["status"] = 'success';
        res["msg"] = response.data["msg"] ?? 'Tienda eliminada correctamente';
        return res;
      } else {
        res["status"] = 'error';
        res["msg"] = response.data["msg"] ?? 'Error al eliminar la tienda';
        return res;
      }
    } on DioException catch (error) {
      res["status"] = 'error';
      res["msg"] = error.response?.data["msg"] ?? 'Error al eliminar la tienda';
      return res;
    } catch (error) {
      res["status"] = 'error';
      res["msg"] = 'Error inesperado: $error';
      return res;
    }
  }

  @override
  Future<MarketerStore> createUpdateBanner(Map<String, dynamic> storeLike, String country, String storeId) {
    // TODO: implement createUpdateBanner
    throw UnimplementedError();
  }

  @override
  Future<List<BannerStore>> getBannersByStore(String country, int storeId) async{
     try {
      final response = await dio.get('/store-banners/$country/$storeId');
      final banners = <BannerStore>[];
      for (final banner in response.data['zdata']) {
        banners.add(BannerStoreMapper.jsonToEntity(banner));
      }
      return banners;
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
  Future<void> getProductsByStore(String country, String id) {
    // TODO: implement getProductsByStore
    throw UnimplementedError();
  }
  
}
