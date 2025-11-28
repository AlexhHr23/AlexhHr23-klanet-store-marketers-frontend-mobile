import 'package:klanetmarketers/features/commissions/domain/entities/entities.dart';

abstract class CommissionDatasource {
  Future<List<NetworkCommission>> getNetworkCommissions(String date);
}