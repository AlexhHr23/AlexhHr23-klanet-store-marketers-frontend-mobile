import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/shared/infrastructure/services/s3_service_impl.dart';
import 'package:klanetmarketers/features/stores/domain/domain.dart';
import 'package:klanetmarketers/features/stores/infrastructure/mappers/mappers.dart';
import 'package:uuid/uuid.dart';

class StoresDatasourceImpl extends StoresDatasource {
  final String accessToken;
  late final Dio dio;
  final s3Service = S3ServiceImpl();

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
  Future<BannerStore> createUpdateBanner(Map<String, dynamic> bannerLike, String country, String storeId) async{
   try {
    final uuidDesktop = Uuid().v4();
    final uuidMobile = Uuid().v4();

    final XFile fileDesktop = bannerLike['archivo_imagen'];
    final XFile fileMobile = bannerLike['archivo_imagen_movil'];

    final desktopKey = 'banners/$uuidDesktop.webp';
    final mobileKey = 'banners/$uuidMobile.webp';

    print('BannerLike: $bannerLike');

    final signedDesktopUrl = await s3Service.requestSignedUrl({
      'method': 'PUT',
      'bucket': 'MKT_BANNERS',
      'key': desktopKey,
      'ttl': 102400,
    });

    print('signedDesktopUrl: $signedDesktopUrl');

    await s3Service.uploadFile(
      signedDesktopUrl,
      await fileDesktop.readAsBytes(),
      'image/webp',
    );

    final signedMobileUrl = await s3Service.requestSignedUrl({
      'method': 'PUT',
      'bucket': 'MKT_BANNERS',
      'key': mobileKey,
      'ttl': 102400,
    });

  

    await s3Service.uploadFile(
      signedMobileUrl,
      await fileMobile.readAsBytes(),
      'image/webp',
    );

    bannerLike['archivo_imagen'] = desktopKey;
    bannerLike['archivo_imagen_movil'] = mobileKey;

    // print('bannerLike modificado: $bannerLike');

    final int? id = bannerLike["id"];
    final String method = (id == null) ? 'POST' : 'PUT';
    final String url = (id == null)
        ? '/store-banners/$country'
        : '/store-banners/$country/$id';

    bannerLike.remove('id');

    final response = await dio.request(
      url,
      data: bannerLike,
      options: Options(method: method),
    );

    return BannerStoreMapper.jsonToEntity(response.data["data"]);
  } on DioException catch (e,s) {
    print(e);
    print(s);
    final statusCode = e.response?.statusCode;
    if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
      throw Exception('Error al crear el banner');
    }
    throw Exception('Error al crear el banner');
  } catch (error) {
    throw Exception(error);
  }
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
  Future<List<ProductoStore>> getProductsByStore(String country, int storeId) async{
   try {
      final response = await dio.get('/store-product/$country/$storeId');
      final products = <ProductoStore>[];
      for (final product in response.data['data']['zdata']) {
        products.add(ProductStoreMapper.jsonToEntity(product));
      }
      return products;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        throw Exception('Error al obtener los paises');
      }
      throw Exception('Error al obtener los paises');
    } catch (e, s) {
      print('Error no controlado: $e');
      print('Error no controlado: $s');
      throw Exception(e);
    }
  }
  
  @override
  Future<String> deleteProductByStore(String country, int productId) async {
    try {
      final response = await dio.delete('/store-product/$country/$productId');
      return response.data['status'];
    } on DioException catch (error) {
      print('error: $error');
      return error.response!.data['status'];
    } catch (error) {
      print('error: $error');
      return 'Error inesperado: $error';
    }
  }
  
}
