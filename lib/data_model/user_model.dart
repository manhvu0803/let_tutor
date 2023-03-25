import 'package:flutter/material.dart';

import 'user.dart';
import 'wallet.dart';

class UserModel extends ChangeNotifier {
  User _user = User(wallet: Wallet(createdAt: DateTime.now()));

  User get user => _user;

  set user(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}