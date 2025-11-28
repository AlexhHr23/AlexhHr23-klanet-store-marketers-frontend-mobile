

import 'package:klanetmarketers/features/commissions/domain/entities/entities.dart';

abstract class CommissionRepository {
  Future<List<NetworkCommission>> getNetworkCommissions(String date);  
}