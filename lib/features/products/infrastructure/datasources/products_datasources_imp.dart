import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/products/domain/domain.dart';
import 'package:klanetmarketers/features/products/infrastructure/mappers/mappers.dart';

class ProductsDatasourcesImp extends ProductsDatasource {
  final String accessToken;
  late final Dio dio;

  ProductsDatasourcesImp({required this.accessToken})
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
  Future<List<CategoryProduct>> getCategoriesByCountry(String country) async {
    try {
      final response = await dio.get('/products/categories/$country');
      final categories = <CategoryProduct>[];
      for (final category in response.data) {
        categories.add(CategoryProductMapper.jsonToEntity(category));
      }
      return categories;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        throw Exception('Error al obtener las categorias');
      }
      throw Exception('Error al obtener las categorias');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ListProducts> getProductsByCategory(
    String country,
    int categoryId,
  ) async {
    try {
      final response = await dio.get(
        '/products/$country?categoria=$categoryId',
      );
      final products = ListProductMapper.jsonToEntity(response.data);
      return products;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        throw Exception('Error al obtener las categorias');
      }
      throw Exception('Error al obtener las categorias');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> addProductToFavorite(String country, int productId) async {
    try {
      final response = await dio.post(
        '/marketer-prod-fav/$country',
        data: {'id_producto': productId, 'activo': '1'},
      );
      print('response: $response');
      return response.data['status'];
    } on DioException catch (e) {
      print('error: $e');
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        return e.response!.data['status'];
      }
      return 'error';
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> deleteProductFromFavorite(
    String country,
    int productId,
  ) async {
    try {
      final response = await dio.delete(
        '/marketer-prod-fav/$country/$productId',
      );
      return response.data['status'];
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        return e.response!.data['status'];
      }
      return 'error';
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<String> addProductToStore(String country, int productId, int storeId) async{
     try {
      final response = await dio.post(
        '/store-product/$country',
        data: {'id_producto': productId, 'id_tienda': storeId},
      );
      return response.data['status'];
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 299 && statusCode <= 502) {
        return e.response!.data['status'];
      }
      return 'error';
    } catch (e) {
      throw Exception(e);
    } 
  }
}
