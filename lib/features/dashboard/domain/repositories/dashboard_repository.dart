import '../entities/entities.dart';

abstract class DashboardRepository {
  Future<Balance> getTimeZones();
}
