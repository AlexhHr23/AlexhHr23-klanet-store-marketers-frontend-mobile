class User {
  // bool isLogged;
  String jwt;
  String marketer;
  Preferences preferences;
  Profile profile;
  String roles;
  String uid;
  String zid;

  User({
    // required this.isLogged,
    required this.jwt,
    required this.marketer,
    required this.preferences,
    required this.profile,
    required this.roles,
    required this.uid,
    required this.zid,
  });

  factory User.empty() {
    return User(
      // isLogged: false,
      jwt: '',
      marketer: '0',
      preferences: Preferences(
        prefCountry: 'MX',
        prefCurrency: 'MXN',
        prefLanguage: 'es_MX',
        prefTimeZone: '-06:00',
      ),
      profile: Profile(
        lastname1: '',
        lastname2: '',
        sellerCode: '',
        documentIdentity: '',
        photo: '',
        internal: '',
        name: '',
        gender: '',
        telIso2: '',
        phone: '',
        username: '',
      ),
      roles: '',
      uid: '0',
      zid: '',
    );
  }

  User copyWith({
    String? jwt,
    String? marketer,
    Preferences? preferences,
    Profile? profile,
    String? roles,
    String? uid,
    String? zid,
  }) {
    return User(
      // isLogged: isLogged ?? this.isLogged,
      jwt: jwt ?? this.jwt,
      marketer: marketer ?? this.marketer,
      preferences: preferences ?? this.preferences,
      profile: profile ?? this.profile,
      roles: roles ?? this.roles,
      uid: uid ?? this.uid,
      zid: zid ?? this.zid,
    );
  }
}

// class Jwt {
//   final String accessToken;
//   final int expiresIn;

//   Jwt({required this.accessToken, required this.expiresIn});

//   Jwt copyWith({String? accessToken, int? expiresIn}) {
//     return Jwt(
//       accessToken: accessToken ?? this.accessToken,
//       expiresIn: expiresIn ?? this.expiresIn,
//     );
//   }
// }

class Profile {
  final String lastname1;
  final String lastname2;
  final String sellerCode;
  final String photo;
  final String documentIdentity;
  final String internal;
  final String name;
  final String gender;
  final String telIso2;
  final String phone;
  final String username;

  Profile({
    required this.lastname1,
    required this.lastname2,
    required this.sellerCode,
    required this.photo,
    required this.documentIdentity,
    required this.internal,
    required this.name,
    required this.gender,
    required this.telIso2,
    required this.phone,
    required this.username,
  });

  Profile copyWith({
    String? lastname1,
    String? lastname2,
    String? sellerCode,
    String? photo,
    String? documentIdentity,
    String? internal,
    String? name,
    String? gender,
    String? telIso2,
    String? phone,
    String? username,
  }) {
    return Profile(
      lastname1: lastname1 ?? this.lastname1,
      lastname2: lastname2 ?? this.lastname2,
      sellerCode: sellerCode ?? this.sellerCode,
      photo: photo ?? this.photo,
      documentIdentity: documentIdentity ?? this.documentIdentity,
      internal: internal ?? this.internal,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      telIso2: telIso2 ?? this.telIso2,
      phone: phone ?? this.phone,
      username: username ?? this.username,
    );
  }
}

class Preferences {
  final String prefCountry;
  final String prefCurrency;
  final String prefLanguage;
  final String prefTimeZone;

  Preferences({
    required this.prefCountry,
    required this.prefCurrency,
    required this.prefLanguage,
    required this.prefTimeZone,
  });

  Preferences copyWith({
    String? prefCountry,
    String? prefCurrency,
    String? prefLanguage,
    String? prefTimeZone,
  }) {
    return Preferences(
      prefCountry: prefCountry ?? this.prefCountry,
      prefCurrency: prefCurrency ?? this.prefCurrency,
      prefLanguage: prefLanguage ?? this.prefLanguage,
      prefTimeZone: prefTimeZone ?? this.prefTimeZone,
    );
  }
}
