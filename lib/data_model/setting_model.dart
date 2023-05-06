import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingModel extends ChangeNotifier {
  bool _isDarkMode = false;
  String _language = "VI";

  SettingModel() {
    _getPrefs();
  }

  void _getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool("setting_isDarkMode") ?? false;
    _language = prefs.getString("setting_language") ?? "VI";
  }

  bool get isDarkMode => _isDarkMode;

  String get language => _language;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    SharedPreferences.getInstance().then((prefs) => prefs.setBool("setting_isDarkMode", value));
    notifyListeners();
  }

  set language(String value) {
    _language = value;
    SharedPreferences.getInstance().then((prefs) => prefs.setString("setting_language", value));
    notifyListeners();
  }
}