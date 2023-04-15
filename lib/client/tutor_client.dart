import 'dart:math';

import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/data_model/schedule.dart';
import 'package:let_tutor/data_model/student_review.dart';
import 'package:let_tutor/data_model/tutor.dart';
import 'package:let_tutor/utils/utils.dart';

Future<Tutor> getTutor(String id) async {
  var json = await Client.jsonFromAuthGet(url("tutor/$id"));
  return Tutor.fromJson(json);
}

Future<List<Tutor>> searchTutor({
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
      "date": (date == null) ? null : date.dateWeekStringGmt,
      "nationality": nationality,
      "tutoringTimeAvailable": [
        (fromTime != null) ? fromTime.millisecondsSinceEpoch : null,
        (toTime != null) ? toTime.millisecondsSinceEpoch : fromTime?.add(const Duration(days: 1)).millisecondsSinceEpoch,
      ]
    },
    "page": max(1, page),
    "perPage": perPageCount,
    "search": searchTerm
  };

  var json = await Client.jsonFromAuthPost("tutor/search", body: body);
  return (json["rows"] as List).toNewList((json) => Tutor.fromJson(json));
}

Future<List<Schedule>> getTutorScheduleNow(String tutorId) {
  var startTime = DateTime.now().date;
  return getTutorSchedule(tutorId: tutorId, startTime: startTime, endTime: startTime.add(const Duration(days: 7)));
}

Future<List<Schedule>> getTutorSchedule({
  required String tutorId,
  required DateTime startTime,
  required DateTime endTime})
async {
  var queries = {
    "tutorId": tutorId,
    "startTimestamp": startTime.millisecondsSinceEpoch,
    "endTimestamp": endTime.millisecondsSinceEpoch
  };

  var json = await Client.jsonFromAuthGet(url("schedule", queries: queries));
  return (json["scheduleOfTutor"] as List).toNewList((json) => Schedule.fromJson(json));
}

Future<List<StudentReview>> getReviews({required String tutorId, int page = 1, int perPageCount = 5}) async {
  var queries = {
    // For some reason this cannot be turned to string
    "page": page.toString(),
    "perPage": perPageCount
  };

  var json = await Client.jsonFromAuthGet(url("feedback/v2/$tutorId", queries: queries));
  return (json["data"]["rows"] as List).toNewList((json) => StudentReview.fromJson(json));
}

Future<void> switchTutorFavorite(String tutorId) async {
  await Client.jsonFromAuthPost(
    "user/manageFavoriteTutor",
    body: { "tutorId": tutorId }
  );
}
