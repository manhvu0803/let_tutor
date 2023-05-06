import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/user.dart';
import 'package:let_tutor/data_model/wallet.dart';

class UserModel extends ChangeNotifier {
  User _user;

  UserModel(User? user) : _user = (user != null) ? user : User(wallet: Wallet(createdAt: DateTime.now()));

  User get user => _user;

  Wallet? get wallet => _user.wallet;

  set user(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  set wallet(Wallet? wallet) {
    _user.wallet = wallet;
    notifyListeners();
  }
}