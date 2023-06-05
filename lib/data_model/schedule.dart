import 'package:let_tutor/data_model/tutor_review.dart';

import 'user.dart';

class Schedule {
  DateTime createdAt = DateTime(0);
  DateTime updatedAt = DateTime(0);
  String id = "";
  String studentRequest = "";
  String tutorReview = "";
  double scoreByTutor = 0;
  String recordUrl = "";
  String lessonPlanId = "";
  String cancelNote = "";
  bool isDeleted = false;
  DateTime startTime = DateTime(0);
  DateTime endTime = DateTime(0);
  String scheduleInfoId = "";
  TutorReview? classReview;
  bool showRecordUrl = false;
  bool isBooked;
  User? tutor;

  Schedule({
    this.id = "",
    this.studentRequest = "",
    this.tutorReview = "",
    DateTime? startTime,
    DateTime? endTime,
    this.isBooked = false,
    this.classReview,
    this.tutor
  }) :
    startTime = startTime ?? DateTime(0),
    endTime = endTime ?? DateTime(0);


  Schedule.fromJson(Map<String, dynamic> json) :
    id = json["scheduleDetails"]?[0]?["id"] ?? json["id"],
    studentRequest = json["studentRequest"] ?? "",
    tutorReview = json["tutorReview"] ?? "",
    scoreByTutor = double.parse((json["scoreByTutor"] ?? 0).toString()),
    recordUrl = json["recordUrl"] ?? "",
    lessonPlanId = json["lessonPlanId"].toString(),
    isDeleted = json["isDeleted"] ?? false,
    classReview = (json["classReview"] != null) ? TutorReview.fromJson(json["classReview"]) : null,
    showRecordUrl = json["showRecordUrl"] ?? false,
    isBooked = json["isBooked"] ?? json["scheduleDetails"]?[0]?["isBooked"] ?? false
  {
    if (json["createdAtTimeStamp"] != null) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAtTimeStamp"]);
    }
    else if (json["createdAt"] != null) {
      createdAt = DateTime.parse(json["createdAt"]);
    }

    if (json["updatedAtTimeStamp"] != null) {
      updatedAt = DateTime.fromMillisecondsSinceEpoch(json["updatedAtTimeStamp"]);
    }
    else if (json["updatedAt"] != null) {
      updatedAt = DateTime.parse(json["updatedAt"]);
    }

    if (json["startTimestamp"] != null) {
      startTime = DateTime.fromMillisecondsSinceEpoch(json["startTimestamp"]);
    }

    if (json["endTimestamp"] != null) {
      endTime = DateTime.fromMillisecondsSinceEpoch(json["endTimestamp"]);
    }

    var scheduleDetail = json["scheduleDetailInfo"];

    if (scheduleDetail == null) {
      return;
    }

    tutor = User.fromJson(scheduleDetail["scheduleInfo"]?["tutorInfo"]);
    scheduleInfoId = scheduleDetail["scheduleId"] ?? 0;
    startTime = DateTime.fromMillisecondsSinceEpoch(scheduleDetail["startPeriodTimestamp"]);
    endTime = DateTime.fromMillisecondsSinceEpoch(scheduleDetail["endPeriodTimestamp"]);
  }
}