import '../models/user_model.dart';
import 'model_repository.dart';

class UserRepository extends ModelRepository<UserModel> {
  const UserRepository()
    : super(
        uri: 'users',
        fromJson: UserModel.fromJson,
      );
}
