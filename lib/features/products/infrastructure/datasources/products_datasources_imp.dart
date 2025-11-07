

import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/products/domain/domain.dart';
import 'package:klanetmarketers/features/products/infrastructure/mappers/mappers.dart';

class ProductsDatasourcesImp extends ProductsDatasource{
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
  Future<List<CategoryProduct>> getCategoriesByCountry(String country) async{
    try{
      final response = await dio.get('/products/categories/$country');
    final categories = <CategoryProduct>[]; 
    for (final category in response.data) {
      categories.add(CategoryProductMapper.jsonToEntity(category));
    }
    return categories;
    }on DioException catch(e){
      final statusCode = e.response?.statusCode;
      if(statusCode != null && statusCode >= 299 && statusCode <= 502){
        throw Exception('Error al obtener las categorias');
      }
      throw Exception('Error al obtener las categorias');
    }catch(e){
      throw Exception(e);
    }
  }
}