import '../entities/entities.dart';

abstract class DashboardDatasource {
  Future<Balance> getTimeZones();
  Future<MarketerProfile> getMarketerProfile();
  Future<List<String>> getBanners();
}
