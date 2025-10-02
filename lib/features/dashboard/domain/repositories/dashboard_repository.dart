import '../entities/entities.dart';

abstract class DashboardRepository {
  Future<Balance> getTimeZones();
  Future<MarketerProfile> getMarketerProfile();
  Future<List<String>> getBanners();
}
