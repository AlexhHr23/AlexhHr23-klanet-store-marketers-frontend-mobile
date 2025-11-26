import 'package:klanetmarketers/features/packages/domain/domain.dart';
import 'package:klanetmarketers/features/packages/infrastructure/datasources/package_datasource_impl.dart';

class PackageRepositoryImpl extends PackagesRepository {
  final PackageDatasourceImpl datasource;

  PackageRepositoryImpl(this.datasource);

  @override
  Future<Package> createPackage(
    String country,
    Map<String, dynamic> packageLike,
  ) {
    return datasource.createPackage(country, packageLike);
  }

  @override
  Future<List<Package>> getPackages(String country) {
    return datasource.getPackages(country);
  }

  @override
  Future<String> deletePackage(String country, int packageId) {
    return datasource.deletePackage(country, packageId);
  }

  @override
  Future<Package> getPackageById(String country, int packageId) {
    return datasource.getPackageById(country, packageId);
  }

  @override
  Future<String> deleteProductFromPackage(
    String country,
    int packageId,
    int productId,
  ) {
    return datasource.deleteProductFromPackage(country, packageId, productId);
  }
}
