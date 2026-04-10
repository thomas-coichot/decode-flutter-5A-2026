enum RoleUser{
  admin('ROLE_ADMIN'),
  user('ROLE_USER');

  final String value;

  const RoleUser(this.value);

  RoleUser fromValue(String value){
    switch (value) {
      case 'ROLE_ADMIN':
        return RoleUser.admin;
      case 'ROLE_USER':
        return RoleUser.user;
      default:
        throw Exception('Unknown role: $value');
    }
  }
}

class UserModel {
  final String email;
  final String lastname;
  final String firstname;
  final RoleUser role;


  const UserModel({
    required this.email,
    required this.lastname,
    required this.firstname,
    required this.role,
  });
}