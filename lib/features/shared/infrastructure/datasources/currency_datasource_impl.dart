import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/shared/domain/datasources/currency_datasource.dart';
import 'package:klanetmarketers/features/shared/domain/entities/currency.dart';

import '../mappers/mappers.dart';

class CurrencyDatasourceImpl extends CurrencyDatasource {
  final String accessToken;
  late final Dio dio;

  CurrencyDatasourceImpl({required this.accessToken})
    : dio = Dio(
        BaseOptions(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'x-api-key': Environment.fireclubKey,
          },
          baseUrl: Environment.baseUrlMarket,
        ),
      );
  @override
  Future<List<Currency>> getCurrencies() async {
    try {
      final response = await dio.get('/select/currencies');
      final currencies = <Currency>[];
      for (final currency in response.data ?? []) {
        currencies.add(CurrencyMapper.jsonToEntity(currency));
      }
      return currencies;
    } catch (e) {
      throw Exception(e);
    }
  }
}
