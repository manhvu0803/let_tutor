import 'dart:convert';

import 'package:http/http.dart' as http;

import 'data_model/schedule.dart';
import 'data_model/token.dart';
import 'data_model/user.dart';

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

  static Future<List<Schedule>> getSchedule() async {
    final queries = {
      "page": "1",
      "perPage": "10",
      "dateTimeGte": "${DateTime.now().subtract(_cutLimit).millisecondsSinceEpoch}",
      "orderBy": "meeting",
      "sortBy": "asc"
    };

    print(DateTime.now().subtract(_cutLimit).millisecondsSinceEpoch);
    var json = await _getJson(http.get(
      _url("booking/list/student", queries: queries),
      headers: {"Authorization" : "Bearer ${accessToken.value}"}
    ));

    var scheduleList = <Schedule>[];

    for (var scheduleJson in json["data"]["rows"]) {
      scheduleList.add(Schedule.fromJson(scheduleJson));
    }

    return scheduleList;
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

  print(response.body);
  var json = jsonDecode(response.body);

  if (response.statusCode < 200 || 300 <= response.statusCode) {
    throw Exception("Code ${response.statusCode}: ${json["message"]}");
  }

  return json;
}