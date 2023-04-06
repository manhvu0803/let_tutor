import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data_model/course.dart';
import 'data_model/schedule.dart';
import 'data_model/token.dart';
import 'data_model/tutor.dart';
import 'data_model/user.dart';
import 'utils.dart';

const _baseUrl = "sandbox.api.lettutor.com";

const _cutLimit = Duration(minutes: 30);

class Client {
  static Token accessToken = Token("", expires: DateTime(0));
  static Token refreshToken = Token("", expires: DateTime(0));
  static final Client instance = Client();

  static Future<User> login(String email, String password) async {
    var json = await _getJson(http.post(
      _url("auth/login"),
      body: {
        "email": email,
        "password": password
      }
    ));

    var tokens = json["tokens"] ?? json["token"];
    accessToken = Token.fromJson(tokens["access"] ?? tokens["accessToken"]);
    refreshToken = Token.fromJson(tokens["refresh"] ?? tokens["refreshToken"]);
    return User.fromJson(json["user"]);
  }

  static Future<List<Schedule>> getSchedule({int page = 1}) async {
    final queries = {
      "page": "$page",
      "perPage": "10",
      "dateTimeGte": "${DateTime.now().subtract(_cutLimit).millisecondsSinceEpoch}",
      "orderBy": "meeting",
      "sortBy": "asc"
    };

    var json = await _jsonFromAuthGet(_url("booking/list/student", queries: queries));

    var scheduleList = <Schedule>[];

    for (var scheduleJson in json["data"]["rows"]) {
      scheduleList.add(Schedule.fromJson(scheduleJson));
    }

    return scheduleList;
  }

  static Future<List<Schedule>> getHistory({int page = 1}) async {
    final queries = {
      "page": "$page",
      "perPage": "10",
      "dateTimeLte": "${DateTime.now().millisecondsSinceEpoch}",
      "orderBy": "meeting",
      "sortBy": "desc"
    };

    var json = await _jsonFromAuthGet(_url("booking/list/student", queries: queries));

    var scheduleList = <Schedule>[];

    for (var scheduleJson in json["data"]["rows"]) {
      scheduleList.add(Schedule.fromJson(scheduleJson));
    }

    return scheduleList;
  }

  static Future<Tutor> getTutor(String id) async {
    var json = await _jsonFromAuthGet(_url("tutor/$id"));
    return Tutor.fromJson(json);
  }

  static Future<Course> getCourse(String id) async {
    var json = await _jsonFromAuthGet(_url("course/$id"));
    return Course.fromJson(json["data"]);
  }

  static Future<List<Tutor>> searchTutor({int page = 1}) async {
    var body = {
      "page": "$page",
      "perPage": "5",
      "filter": jsonEncode({
        "date": "null",
        "nationality": "{}",
        "specialties": "[]"
      })
    };

    var json = await _jsonFromAuthPost("tutor/search", body: body);
    return buildList(json["rows"], (dynamic json) => Tutor.fromJson(json));
  }

  static Future<Map<String, dynamic>> _jsonFromAuthGet(Uri uri) {
    return _getJson(
      http.get(uri, headers: {"Authorization" : "Bearer ${accessToken.value}"})
    );
  }

  static Future<Map<String, dynamic>> _jsonFromAuthPost(String url, {Object? body}) {
    return _getJson(
      http.post(
        _url(url),
        headers: {"Authorization" : "Bearer ${accessToken.value}"},
        body: body
      )
    );
  }
}

Uri _url(String arg, {Map<String, dynamic>? queries}) {
  return Uri.https(_baseUrl, arg, queries);
}

Future<Map<String, dynamic>> _getJson(Future<http.Response> request) async {
  var response = await request;

  if (300 <= response.statusCode && response.statusCode < 400) {
    throw Exception("Code ${response.statusCode}");
  }

  debugPrint(response.body);
  var json = jsonDecode(response.body);

  if (response.statusCode < 200 || 300 <= response.statusCode) {
    throw Exception("Code ${response.statusCode}: ${json["message"]}");
  }

  return json;
}