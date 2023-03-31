import 'dart:convert';

import 'package:http/http.dart' as http;

import 'data_model/token.dart';
import 'data_model/user.dart';

const _baseUrl = "https://sandbox.api.lettutor.com";

Uri _url(String arg) {
  return Uri.parse("$_baseUrl/$arg");
}

class Client {
  static Token accessToken = Token("", expires: DateTime(0));
  static Token refreshToken = Token("", expires: DateTime(0));
  static final Client instance = Client();

  static Future<User> login(String email, String password) async {

    var response = await http.post(
      _url("auth/login"),
      body: {
        "email": email,
        "password": password
      }
    );

    final json = jsonDecode(response.body);

    if (response.statusCode < 200 || 300 <= response.statusCode) {
      throw Exception(json["message"].toString());
    }

    var tokens = json["tokens"] ?? json["token"];
    accessToken = Token.fromJson(tokens["access"] ?? tokens["accessToken"]);
    refreshToken = Token.fromJson(tokens["refresh"] ?? tokens["refreshToken"]);
    return User.fromJson(json["user"]);
  }
}