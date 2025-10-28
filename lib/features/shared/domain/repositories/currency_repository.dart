import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';

abstract class CurrencyRepository {
  Future<List<Currency>> getCurrencies();
}
