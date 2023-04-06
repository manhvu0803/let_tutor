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
  Object classReview = "";
  bool showRecordUrl = false;
  User tutor;

  Schedule.fromJson(Map<String, dynamic> json) :
    createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAtTimeStamp"]),
    updatedAt = DateTime.fromMillisecondsSinceEpoch(json["createdAtTimeStamp"]),
    id = json["id"],
    studentRequest = json["studentRequest"] ?? "",
    tutorReview = json["tutorReview"] ?? "",
    scoreByTutor = double.parse((json["scoreByTutor"] ?? 0).toString()),
    recordUrl = json["recordUrl"] ?? "",
    lessonPlanId = json["lessonPlanId"] ?? "",
    isDeleted = json["isDeleted"],
    scheduleInfoId = json["scheduleDetailInfo"]["scheduleId"] ?? 0,
    startTime = DateTime.fromMillisecondsSinceEpoch(json["scheduleDetailInfo"]["startPeriodTimestamp"]),
    endTime = DateTime.fromMillisecondsSinceEpoch(json["scheduleDetailInfo"]["endPeriodTimestamp"]),
    classReview = json["classReview"] ?? "",
    showRecordUrl = json["showRecordUrl"],
    tutor = User.fromJson(json["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]);
}