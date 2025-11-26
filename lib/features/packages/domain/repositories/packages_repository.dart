import 'package:klanetmarketers/features/packages/domain/entities/entities.dart';

abstract class PackagesRepository {
  Future<Package> createPackage(
    String country,
    Map<String, dynamic> packageLike,
  );
  Future<List<Package>> getPackages(String country);
  Future<String> deletePackage(String country, int packageId);
  Future<Package> getPackageById(String country, int packageId);
  Future<String> deleteProductFromPackage(
    String country,
    int packageId,
    int productId,
  );
}
