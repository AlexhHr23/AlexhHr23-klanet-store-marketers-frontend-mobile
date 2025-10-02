import 'package:klanetmarketers/features/dashboard/domain/entities/entities.dart';

class BalanceMapper {
  static Balance jsonToEntity(Map<String, dynamic> json) => Balance(
    balance: json['data'],
    timeZone: TimeZoneMapper.jsonToEntity(json['zdata']),
  );
}

class TimeZoneMapper {
  static TimeZoneServer jsonToEntity(Map<String, dynamic> json) =>
      TimeZoneServer(
        time: json['time'] ?? '',
        tzServer: json['tz_server'] ?? '',
      );
}
