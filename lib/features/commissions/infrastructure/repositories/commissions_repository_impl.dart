
import 'package:klanetmarketers/features/commissions/domain/domain.dart';
import 'package:klanetmarketers/features/commissions/infrastructure/datasources/commission_datasource_impl.dart';

class CommissionsRepositoryImpl extends CommissionRepository{
  final CommissionDatasourceImpl datasource;

  CommissionsRepositoryImpl(this.datasource);
  @override
  Future<List<NetworkCommission>> getNetworkCommissions(String date) {
    return datasource.getNetworkCommissions( date);
  }

}