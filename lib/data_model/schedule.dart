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
  String classReview = "";
  bool showRecordUrl = false;

  Schedule.fromJson(Map<String, dynamic> json) :
    createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAtTimeStamp"]),
    updatedAt = DateTime.fromMillisecondsSinceEpoch(json["createdAtTimeStamp"]),
    id = json["id"],
    studentRequest = json["studentRequest"] ?? "",
    tutorReview = json["tutorReview"] ?? "",
    scoreByTutor = json["scoreByTutor"] ?? 0,
    recordUrl = json["scoreByTutor"],
    lessonPlanId = json["scoreByTutor"] ?? "",
    isDeleted = json["isDeleted"],
    scheduleInfoId = json["scheduleDetailInfo"]["scheduleId"] ?? 0,
    startTime = DateTime.fromMillisecondsSinceEpoch(json["startPeriodTimestamp"]),
    startTime = DateTime.fromMillisecondsSinceEpoch(json["endPeriodTimestamp"]),
    classReview = json["classReview"] ?? "",
    showRecordUrl = json["showRecordUrl"];
}