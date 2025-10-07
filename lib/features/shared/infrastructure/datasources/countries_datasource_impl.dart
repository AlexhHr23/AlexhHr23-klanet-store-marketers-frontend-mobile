import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/shared/domain/domain.dart';
import 'package:klanetmarketers/features/shared/infrastructure/mappers/mappers.dart';

class CountriesDatasourceImpl extends CountriesDatasource {
  final String accessToken;
  late final Dio dio;

  CountriesDatasourceImpl({required this.accessToken})
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
  Future<List<Country>> getCountries() async {
    try {
      final response = await dio.get('/select/paises');
      final countries = <Country>[];
      for (final country in response.data ?? []) {
        countries.add(CountryMapper.jsonToEntity(country));
      }
      return countries;
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
