enum RoleUser {
  admin('ROLE_ADMIN'),
  user('ROLE_USER')
  ;

  final String value;

  const RoleUser(this.value);

  static RoleUser fromValue(String value) {
    switch (value) {
      case 'ROLE_ADMIN':
        return RoleUser.admin;
      case 'ROLE_USER':
        return RoleUser.user;
      default:
        throw Exception('Unknown role: $value');
    }
  }

  String get label {
    switch (this) {
      case RoleUser.admin:
        return 'Administrateur';
      case RoleUser.user:
        return 'Utilisateur';
    }
  }
}

class UserModel {
  final String id;
  final String email;
  final String lastname;
  final String firstname;
  final List<RoleUser> roles;
  final String? languageId;

  const UserModel({
    required this.id,
    required this.email,
    required this.lastname,
    required this.firstname,
    required this.roles,
    this.languageId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      roles: json['roles'].map<RoleUser>((e) => RoleUser.fromValue(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'lastname': lastname,
      'firstname': firstname,
      'roles': roles.map((e) => e.value).toList(),
      'language_id': languageId,
    };
  }

  String get fullName => '$firstname $lastname';
}
