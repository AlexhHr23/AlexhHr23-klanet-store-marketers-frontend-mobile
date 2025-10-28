import 'package:klanetmarketers/features/shared/domain/entities/currency.dart';
import 'package:klanetmarketers/features/shared/domain/repositories/currency_repository.dart';
import 'package:klanetmarketers/features/shared/infrastructure/datasources/currency_datasource_impl.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final CurrencyDatasourceImpl datasource;

  CurrencyRepositoryImpl(this.datasource);

  @override
  Future<List<Currency>> getCurrencies() {
    return datasource.getCurrencies();
  }
}
