import 'package:flutter/material.dart';

import 'user.dart';
import 'wallet.dart';

class UserModel extends ChangeNotifier {
  User _user = User(wallet: Wallet(createdAt: DateTime.now()));

  User get user => _user;

  Wallet get wallet => _user.wallet;

  set user(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  set wallet(Wallet wallet) {
    _user.wallet = wallet;
    notifyListeners();
  }
}