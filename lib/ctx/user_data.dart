import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  late UserCredential? _user;

  void setUserData(UserCredential user) {
    _user = user;
    notifyListeners();
  }

  UserCredential? getUserData() {
    return _user;
  }
}
