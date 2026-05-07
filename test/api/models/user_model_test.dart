import 'package:cours/api/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test User Model from Json', () {
    final UserModel user = const UserModel(
      id: '1',
      email: 'Email',
      lastname: 'Lastname',
      firstname: 'Firstname',
      roles: [RoleUser.user,],
    );

    final UserModel userFromJson = UserModel.fromJson({
      'id': '1',
      'email': 'Email',
      'lastname': 'Lastname',
      'firstname': 'Firstname',
      'roles': ['ROLE_USER'],
    });

    expect(user.email, userFromJson.email);
    expect(user.lastname, userFromJson.lastname);
    expect(user.firstname, userFromJson.firstname);
    expect(user.roles, userFromJson.roles);
    expect(user.languageId, userFromJson.languageId);
  });

  test('Test User Model to Json', () {
    final UserModel user = const UserModel(
      id: '1',
      email: 'Email',
      lastname: 'Lastname',
      firstname: 'Firstname',
      roles: [RoleUser.user,],
    );

    final Map<String, dynamic> userToJson = user.toJson();

    expect(userToJson['id'], '1');
    expect(userToJson['email'], 'Email');
    expect(userToJson['lastname'], 'Lastname');
    expect(userToJson['firstname'], 'Firstname');
    expect(userToJson['roles'], ['ROLE_USER']);
    expect(userToJson['language_id'], isNull);
  });
}