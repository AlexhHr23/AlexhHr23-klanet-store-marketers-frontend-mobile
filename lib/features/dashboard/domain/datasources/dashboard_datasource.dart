import '../entities/entities.dart';

abstract class DashboardDatasource {
  Future<Balance> getTimeZones();
}
