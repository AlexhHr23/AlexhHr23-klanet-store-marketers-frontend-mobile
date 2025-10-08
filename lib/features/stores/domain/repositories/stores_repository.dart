import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';

abstract class StoresRepository {
  Future<List<MarketerStore>> getStores(String country);
  Future<void> getBannersByStore(String country, String id);
  Future<void> getProductsByStore(String country, String id);
}
