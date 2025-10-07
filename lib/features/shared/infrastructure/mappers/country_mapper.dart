import '../../domain/entities/entities.dart';

class CountryMapper {
  static Country jsonToEntity(Map<String, dynamic> json) => Country(
    id: json["ID"] ?? '',
    name: json["Name"] ?? '',
    url: json["Url"] ?? '',
  );
}
