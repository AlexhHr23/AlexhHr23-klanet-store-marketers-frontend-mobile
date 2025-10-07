import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';

abstract class CountriesDatasource {
  Future<List<Country>> getCountries();
}
