import 'package:dio/dio.dart';
import 'package:klanetmarketers/config/constants/enviroment.dart';
import 'package:klanetmarketers/features/dashboard/domain/domain.dart';

class DashboardDatasourceImpl extends DashboardDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.baseUrlPublic,
      headers: {'x-api-key': Environment.fireclubKey},
    ),
  );
}
