

import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/packages/domain/domain.dart';
import 'package:klanetmarketers/features/packages/infrastructure/mappers/mappers.dart';

class PackageDatasourceImpl extends PackageDatasource{
  final String accessToken;
  late final Dio dio;

  PackageDatasourceImpl({required this.accessToken})  : dio = Dio(
        BaseOptions(
          baseUrl: Environment.baseUrlMarket,
          headers: {
            'x-api-key': Environment.fireclubKey,
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
  @override
  Future<List<Package>> getPackages(String country) async{
     try {
      final response = await dio.get('/marketers-paquetes?pais=$country');
      final packages = <Package>[];
      for (final package in response.data['zdata']) {
        packages.add(PackageMapper.jsonToEntity(package));
      }
      return packages;
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
}