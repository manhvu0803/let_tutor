import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:let_tutor/data_model/category.dart';
import 'package:let_tutor/data_model/course.dart';
import 'package:let_tutor/data_model/schedule.dart';
import 'package:let_tutor/data_model/student_review.dart';
import 'package:let_tutor/data_model/token.dart';
import 'package:let_tutor/data_model/tutor.dart';
import 'package:let_tutor/data_model/user.dart';
import 'package:let_tutor/utils/utils.dart';

const _baseUrl = "sandbox.api.lettutor.com";

const _cutLimit = Duration(minutes: 30);

class Client {
  static Token accessToken = Token("", expires: DateTime(0));
  static Token refreshToken = Token("", expires: DateTime(0));
  static bool _isLogin = false;
  static List<Category>? _categories;

  static bool get isLogin => _isLogin;

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
    getCategories().then((value) => _categories = value);
    _isLogin = true;
    return User.fromJson(json["user"]);
  }

  static Future<List<Schedule>> getSchedule({int page = 1}) async {
    final queries = {
      "page": page,
      "perPage": 10,
      "dateTimeGte": DateTime.now().subtract(_cutLimit).millisecondsSinceEpoch,
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
      "page": page,
      "perPage": 10,
      "dateTimeLte": DateTime.now().millisecondsSinceEpoch,
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

  static Future<List<Tutor>> searchTutor({
    int page = 1,
    int perPageCount = 2,
    String? specialty,
    DateTime? date,
    DateTime? fromTime,
    DateTime? toTime,
    String searchTerm = "",
    bool? isVietnamese,
    bool? isNative
  }) async {
    var nationality = <String, bool>{};

    if (isVietnamese != null) {
      nationality["isVietnamese"] = isVietnamese;
    }

    if (isNative != null) {
      nationality["isNative"] = isNative;
    }

    var body = {
      "filters": {
        "specialties": [if (specialty != null && specialty != "all") specialty.toLowerCase().replaceAll(RegExp(r"\s+"), "-")],
        "date": (date == null) ? null : date.dateStringGmt,
        "nationality": nationality,
        "tutoringTimeAvailable": [
          (fromTime != null) ? fromTime.millisecondsSinceEpoch : null,
          (toTime != null) ? toTime.millisecondsSinceEpoch : null,
        ]
      },
      "page": max(1, page),
      "perPage": perPageCount,
      "search": searchTerm
    };

    var json = await _jsonFromAuthPost("tutor/search", body: body);
    return buildList(json["rows"], (dynamic json) => Tutor.fromJson(json));
  }

  static Future<List<Schedule>> getTutorScheduleNow(String tutorId) {
    var startTime = DateTime.now().date;
    return getTutorSchedule(tutorId: tutorId, startTime: startTime, endTime: startTime.add(const Duration(days: 7)));
  }

  static Future<List<Schedule>> getTutorSchedule({
    required String tutorId,
    required DateTime startTime,
    required DateTime endTime})
  async {
    var queries = {
      "tutorId": tutorId,
      "startTimestamp": startTime.millisecondsSinceEpoch,
      "endTimestamp": endTime.millisecondsSinceEpoch
    };

    var json = await _jsonFromAuthGet(_url("schedule", queries: queries));
    return buildList(json["scheduleOfTutor"], (dynamic json) => Schedule.fromJson(json));
  }

  static Future<List<StudentReview>> getReviews({required String tutorId, int page = 1, int perPageCount = 5}) async {
    var queries = {
      // For some reason this cannot be turned to string
      "page": page.toString(),
      "perPage": perPageCount
    };

    var json = await _jsonFromAuthGet(_url("feedback/v2/$tutorId", queries: queries));
    return buildList(json["data"]["rows"], (dynamic json) => StudentReview.fromJson(json));
  }

  static Future<void> switchTutorFavorite(String tutorId) async {
    await _jsonFromAuthPost(
      "user/manageFavoriteTutor",
      body: { "tutorId": tutorId }
    );
  }

  static Future<String> book(String scheduleId, {String note = ""}) async {
    var body = {
      "note": note,
      "scheduleDetailIds" : [scheduleId]
    };

    var json = await _jsonFromAuthPost("booking", body: body);

    return json["message"] ?? "";
  }

  static Future<Course> getCourse(String id) async {
    var json = await _jsonFromAuthGet(_url("course/$id"));
    return Course.fromJson(json["data"]);
  }

  static Future<List<Course>> searchCourse({
    int page = 1,
    int perPageCount = 5,
    List<int>? level,
    bool isAscending = true,
    List<String>? categoryIds,
    String searchTerm = ""
  }) async {
    var queries = {
      "page": page,
      "size": "$perPageCount",
      if (level != null && level.isNotEmpty) "level[]": level,
      "orderBy[]": isAscending ? "ASC" : "DESC",
      if (categoryIds != null && categoryIds.isNotEmpty) "categoryId[]": categoryIds,
      "searchTerm": searchTerm
    };

    print(_url("course", queries: queries));
    var json = await _jsonFromAuthGet(_url("course", queries: queries));
    return buildList(json["data"]["rows"], (dynamic json) => Course.fromJson(json));
  }

  static Future<List<Category>> getCategories() async {
    var json = await _jsonFromAuthGet(_url("content-category"));
    return buildList(json["rows"], (dynamic json) => Category.fromJson(json));
  }

  static List<Category>? get categories => _categories;

  static Future<Map<String, dynamic>> _jsonFromAuthGet(Uri uri) {
    return _getJson(
      http.get(uri, headers: {"Authorization" : "Bearer ${accessToken.value}"})
    );
  }

  static Future<Map<String, dynamic>> _jsonFromAuthPost(String url, {Map<String, Object>? body}) {
    debugPrint(jsonEncode(body));
    return _getJson(
      http.post(
        _url(url),
        headers: {
          "Authorization" : "Bearer ${accessToken.value}",
          "Content-Type" : "application/json"
        },
        body: jsonEncode(body)
      )
    );
  }
}

Uri _url(String arg, {Map<String, Object>? queries}) {
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

Future<Map<String, dynamic>> _getJson(Future<http.Response> request) async {
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