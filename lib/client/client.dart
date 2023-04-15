import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:let_tutor/client/course_client.dart';
import 'package:let_tutor/data_model/token.dart';
import 'package:let_tutor/data_model/user.dart';

export 'tutor_client.dart';
export 'course_client.dart';
export 'schedule_client.dart';
export 'user_client.dart';

const _baseUrl = "sandbox.api.lettutor.com";

class Client {
  static Token accessToken = Token("", expires: DateTime(0));
  static Token refreshToken = Token("", expires: DateTime(0));
  static bool _isLogin = false;

  static bool get isLogin => _isLogin;

  static Future<User> login(String email, String password) async {
    var json = await getJson(http.post(
      url("auth/login"),
      body: {
        "email": email,
        "password": password
      }
    ));

    var tokens = json["tokens"] ?? json["token"];
    accessToken = Token.fromJson(tokens["access"] ?? tokens["accessToken"]);
    refreshToken = Token.fromJson(tokens["refresh"] ?? tokens["refreshToken"]);
    getCategories();
    _isLogin = true;
    print(json["user"]["birthday"]);
    return User.fromJson(json["user"]);
  }

  static Future<Map<String, dynamic>> jsonFromAuthGet(Uri uri) {
    print(uri);
    return getJson(
      http.get(uri, headers: {"Authorization" : "Bearer ${accessToken.value}"})
    );
  }

  static Future<Map<String, dynamic>> jsonFromAuthPost(String locator, {Map<String, Object>? body}) {
    debugPrint(jsonEncode(body));
    return getJson(
      http.post(
        url(locator),
        headers: {
          "Authorization" : "Bearer ${accessToken.value}",
          "Content-Type" : "application/json"
        },
        body: jsonEncode(body)
      )
    );
  }

  static Future<Map<String, dynamic>> jsonFromAuthDelete(String locator, {Map<String, Object>? body}) {
    debugPrint(jsonEncode(body));
    return getJson(
      http.delete(
        url(locator),
        headers: {
          "Authorization" : "Bearer ${accessToken.value}",
          "Content-Type" : "application/json"
        },
        body: jsonEncode(body)
      )
    );
  }

  static Future<Map<String, dynamic>> jsonFromAuthPut(String locator, {Map<String, Object>? body}) {
    debugPrint(jsonEncode(body));
    return getJson(
      http.put(
        url(locator),
        headers: {
          "Authorization" : "Bearer ${accessToken.value}",
          "Content-Type" : "application/json"
        },
        body: jsonEncode(body)
      )
    );
  }
}

Uri url(String arg, {Map<String, Object>? queries}) {
  if (queries != null) {
    for (final key in queries.keys) {
      var value = queries[key];

      if (value is List) {
        for (var i = 0; i < value.length; i++) {
          value[i] = value[i].toString();
        }
      }
      else if (value is! String) {
        var sth = value.toString();
        queries[key] = sth;
      }
    }
  }

  return Uri.https(_baseUrl, arg, queries);
}

Future<Map<String, dynamic>> getJson(Future<http.Response> request) async {
  var response = await request;

  if (300 <= response.statusCode && response.statusCode < 400) {
    throw Exception("Code ${response.statusCode}");
  }

  var json = jsonDecode(response.body);

  if (response.statusCode < 200 || 300 <= response.statusCode) {
    throw Exception("Code ${response.statusCode}: ${json["message"]}");
  }

  return json;
}