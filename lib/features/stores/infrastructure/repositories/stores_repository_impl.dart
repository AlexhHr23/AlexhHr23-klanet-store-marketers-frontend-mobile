import 'package:klanetmarketers/features/stores/domain/domain.dart';
import 'package:klanetmarketers/features/stores/infrastructure/datasources/stores_datasource_impl.dart';

class StoresRepositoryImpl extends StoresRepository {
  final StoresDatasourceImpl datasource;

  StoresRepositoryImpl(this.datasource);

   @override
  Future<MarketerStore> createUpdateStore(Map<String, dynamic> storeLike, String country) {
    return datasource.createUpdateStore(storeLike, country);
  }

  @override
  Future<List<MarketerStore>> getStores(String country) {
    return datasource.getStores(country);
  }

    @override
  Future<BannerStore> createUpdateBanner(Map<String, dynamic> bannerLike, String country, String storeId) {
    return datasource.createUpdateBanner(bannerLike, country, storeId);
  }
  
  @override
 Future<List<BannerStore>> getBannersByStore(String country, int storeId) {
    return datasource.getBannersByStore(country, storeId);
  }

   @override
   Future<Map<String, dynamic>> deleteStore(String country, int storeId) {
    return datasource.deleteStore(country, storeId);
  }

  @override
   Future<List<ProductoStore>> getProductsByStore(String country, int storeId) {
    return datasource.getProductsByStore(country, storeId);
  }
  
 
  
  
}
