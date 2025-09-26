import '../../domain/entities/user.dart';

class UserMapper {
  // De JSON a User
  static User jsonToEntity(Map<String, dynamic> json) => User(
    jwt: json['jwt'] ?? '',
    preferences: PreferencesMapper.prefToEntity(json['preferences']),
    marketer: json['marketer'] ?? '',
    profile: ProfileMapper.profileToEntity(json['profile']),
    roles: json['roles'] ?? '',
    uid: json['uid'] ?? '',
    zid: json['zid'] ?? '',
  );

  static Map<String, dynamic> entityToJson(User user) => {
    'jwt': user.jwt,
    'preferences': PreferencesMapper.entityToJson(user.preferences),
    'marketer': user.marketer,
    'profile': ProfileMapper.entityToJson(user.profile),
    'roles': user.roles,
    'uid': user.uid,
  };
}

class ProfileMapper {
  static Profile profileToEntity(Map<String, dynamic> json) => Profile(
    lastname1: json['apellido1'] ?? '',
    lastname2: json['apellido2'] ?? '',
    sellerCode: json['cod_vendedor'] ?? '',
    documentIdentity: json['documento_identidad'] ?? '',
    photo: json['foto'] ?? '',
    internal: json['interno'] ?? '',
    name: json['nombre'] ?? '',
    gender: json['sexo'] ?? '',
    telIso2: json['tel_iso2'] ?? '',
    phone: json['telefono'] ?? ' ',
    username: json['username'] ?? '',
  );

  static Map<String, dynamic> entityToJson(Profile profile) => {
    'apellido1': profile.lastname1,
    'apellido2': profile.lastname2,
    'cod_vendedor': profile.sellerCode,
    'documento_identidad': profile.documentIdentity,
    'foto': profile.photo,
    'interno': profile.internal,
    'nombre': profile.name,
    'sexo': profile.gender,
    'tel_iso2': profile.telIso2,
    'telefono': profile.phone,
    'username': profile.username,
  };
}

class PreferencesMapper {
  static Preferences prefToEntity(Map<String, dynamic> json) => Preferences(
    prefCountry: json['pref_country'] ?? '',
    prefCurrency: json['pref_currency'] ?? '',
    prefLanguage: json['pref_idioma'] ?? '',
    prefTimeZone: json['pref_time_zone'] ?? '',
  );

  static Map<String, dynamic> entityToJson(Preferences preferences) => {
    'pref_country': preferences.prefCountry,
    'pref_currency': preferences.prefCurrency,
    'pref_idioma': preferences.prefLanguage,
    'pref_time_zone': preferences.prefTimeZone,
  };
}
