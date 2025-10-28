import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';

abstract class CurrencyDatasource {
  Future<List<Currency>> getCurrencies();
}
