import 'package:flutter/foundation.dart';
import 'package:qutub_clinet/models/userModel.dart';

class UserProvider extends ChangeNotifier {
  UserModel userModel;

  void setUser(UserModel user) {
    this.userModel = user;
    notifyListeners();
  }
}
