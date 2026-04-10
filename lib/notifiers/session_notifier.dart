import 'package:flutter/cupertino.dart';

import '../api/models/user_model.dart';

class SessionNotifier  extends ChangeNotifier{
  UserModel? user;

  void onAuthentication(UserModel value){
    user = value;
    notifyListeners();
  }
}