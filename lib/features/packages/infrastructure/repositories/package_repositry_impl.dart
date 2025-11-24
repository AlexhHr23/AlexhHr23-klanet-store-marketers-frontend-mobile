

import 'package:klanetmarketers/features/packages/domain/domain.dart';
import 'package:klanetmarketers/features/packages/infrastructure/datasources/package_datasource_impl.dart';

class PackageRepositoryImpl extends PackagesRepository{
  final PackageDatasourceImpl datasource;

  PackageRepositoryImpl(this.datasource);
  @override
  Future<List<Package>> getPackages(String country) {
    return datasource.getPackages( country);
  }
}