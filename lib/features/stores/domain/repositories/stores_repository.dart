import 'package:klanetmarketers/features/stores/domain/entities/entities.dart';

abstract class StoresRepository {
  Future<MarketerStore>createUpdateStore(Map<String, dynamic> storeLike, String country);
  Future<List<MarketerStore>> getStores(String country);
  Future<Map<String, dynamic>> deleteStore(String country, int id);
   Future<BannerStore>createUpdateBanner(Map<String, dynamic> bannerLike, String country, String storeId);
  Future<List<BannerStore>> getBannersByStore(String country, int storeId);
  Future<List<ProductoStore>> getProductsByStore(String country, int id);
}
