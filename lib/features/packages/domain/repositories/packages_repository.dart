import 'package:klanetmarketers/features/packages/domain/entities/entities.dart';

abstract class PackagesRepository {
  Future<List<Package>> getPackages(String country);
  Future<String> deletePackage(String country, int packageId);
}
