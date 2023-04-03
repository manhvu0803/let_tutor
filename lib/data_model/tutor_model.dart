import 'package:flutter/material.dart';

import 'user.dart';

class TutorModel extends ChangeNotifier{
  final Map<String, User> _tutors = {};

  User? getTutor(String id) {
    return _tutors[id];
  }

  void setTutor(User tutor) {
    _tutors[tutor.id] = tutor;
    notifyListeners();
  }
}