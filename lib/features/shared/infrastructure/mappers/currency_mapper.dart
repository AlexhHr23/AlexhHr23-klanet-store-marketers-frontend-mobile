import 'package:klanetmarketers/features/shared/domain/entities/entities.dart';

class CurrencyMapper {
  static Currency jsonToEntity(Map<String, dynamic> json) =>
      Currency(code: json["codigo"] ?? '', name: json["nombre"] ?? '');
}
