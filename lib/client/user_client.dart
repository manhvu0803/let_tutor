import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/data_model/user.dart';
import 'package:let_tutor/utils/date_time_extension.dart';

Future<User> updateUserInfo({
  required String name,
  required String country,
  required DateTime birthday,
  required String level,
  required String phone,
  String studySchedule = "",
  List<int> learnTopics = const [],
  List<int> testPreparations = const []
}) async {
  var body = {
    "birthday": birthday.isoDateString,
    "country": country,
    "name": name,
    "level": level,
    "phone": phone,
    "learnTopics": learnTopics,
    "studySchedule": studySchedule,
    "testPreparations": testPreparations
  };

  var json = await Client.jsonFromAuthPut("user/info", body: body);
  return User.fromJson(json["user"]);
}