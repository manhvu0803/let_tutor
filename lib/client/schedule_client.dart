import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/data_model/schedule.dart';

const _cutLimit = Duration(minutes: 30);

Future<List<Schedule>> getSchedule({int page = 1}) async {
  final queries = {
    "page": page,
    "perPage": 10,
    "dateTimeGte": DateTime.now().subtract(_cutLimit).millisecondsSinceEpoch,
    "orderBy": "meeting",
    "sortBy": "asc"
  };

  var json = await Client.jsonFromAuthGet(url("booking/list/student", queries: queries));

  var scheduleList = <Schedule>[];

  for (var scheduleJson in json["data"]["rows"]) {
    scheduleList.add(Schedule.fromJson(scheduleJson));
  }

  return scheduleList;
}

Future<List<Schedule>> getHistory({int page = 1}) async {
  final queries = {
    "page": page,
    "perPage": 10,
    "dateTimeLte": DateTime.now().millisecondsSinceEpoch,
    "orderBy": "meeting",
    "sortBy": "desc"
  };

  var json = await Client.jsonFromAuthGet(url("booking/list/student", queries: queries));

  var scheduleList = <Schedule>[];

  for (var scheduleJson in json["data"]["rows"]) {
    scheduleList.add(Schedule.fromJson(scheduleJson));
  }

  return scheduleList;
}

Future<String> book(String scheduleId, {String note = ""}) async {
  var body = {
    "note": note,
    "scheduleDetailIds" : [scheduleId]
  };

  var json = await Client.jsonFromAuthPost("booking", body: body);

  return json["message"] ?? "";
}

Future<String> cancel(String scheduleId, {int cancelReasonId = 4, String note = ""}) async {
  var body = {
    "scheduleDetailId": scheduleId,
    "cancelInfo": {
      "cancelReasonId": cancelReasonId.clamp(1, 4),
      "note": note
    }
  };

  var json = await Client.jsonFromAuthDelete("booking/schedule-detail", body: body);

  return json["message"] ?? "";
}