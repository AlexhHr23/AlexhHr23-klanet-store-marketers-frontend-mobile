import 'package:klanetmarketers/features/shared/domain/domain.dart';

class CountryRepositoryImpl extends CountriesRepository {
  final CountriesDatasource countriesDatasource;

  CountryRepositoryImpl(this.countriesDatasource);
  @override
  Future<List<Country>> getCountries() {
    return countriesDatasource.getCountries();
  }
}
