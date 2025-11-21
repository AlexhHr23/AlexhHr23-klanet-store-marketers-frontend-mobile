

import 'package:klanetmarketers/features/packages/domain/entities/entities.dart';

abstract class PackageDatasource {
  Future<List<Package>> getPackages(String country);
}