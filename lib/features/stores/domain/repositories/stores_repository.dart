

abstract class StoresRepository {
  Future<void> getStores(String country);
  Future<void> getBannersByStore(String country, String id);
  Future<void> getProductsByStore(String country, String id);
}