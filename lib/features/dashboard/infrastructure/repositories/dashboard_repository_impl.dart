import 'package:klanetmarketers/features/dashboard/domain/domain.dart';
import 'package:klanetmarketers/features/dashboard/infrastructure/infrastructure.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardDatasourceImpl datasource;

  DashboardRepositoryImpl(this.datasource);
  @override
  Future<Balance> getTimeZones() async {
    return datasource.getTimeZones();
  }
}
