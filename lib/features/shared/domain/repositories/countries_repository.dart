import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';

abstract class CountriesRepository {
  Future<List<Country>> getCountries();
}
