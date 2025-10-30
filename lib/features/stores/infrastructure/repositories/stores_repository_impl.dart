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
  Future<void> getBannersByStore(String country, String id) {
    return datasource.getProductsByStore(country, id);
  }

  @override
  Future<void> getProductsByStore(String country, String id) {
    return datasource.getProductsByStore(country, id);
  }
  
  @override
   Future<Map<String, dynamic>> deleteStore(String country, int storeId) {
    return datasource.deleteStore(country, storeId);
  }
  
}
