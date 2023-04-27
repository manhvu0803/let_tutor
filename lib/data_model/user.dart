import 'wallet.dart';

class User {
  static List<String> levelStrings = [
    "Beginner",
    "Higher Beginner",
    "Pre-Intermediate",
    "Intermediate",
    "Upper-Intermediate",
    "Advanced",
    "Proficiency"
  ];

  static Map<String, String> countries = {
    "VN": "Viet Nam",
    "US": "USA",
    "BW": "Botswana",
  };

  String id = "";
  String email = "";
  String name = "";
  String avatarUrl = "";
  String country = "";
  String phone = "";
  Set<String> roles = {};
  String language = "";
  DateTime birthday = DateTime(0);
  bool isActivated = false;
  Wallet? wallet;
  String requiredNote = "";
  String level = "";
  bool isPhoneActivated = false;
  int timezone = 0;
  String studySchedule = "";
  bool canSendMessage = false;

  User({required this.wallet});

  User.fromJson(Map<String, dynamic> json) :
    id = json["userId"] ?? json["id"] ?? "",
    email = json["email"] ?? "",
    name = json["name"] ?? "",
    avatarUrl = json["avatar"] ?? "",
    country = json["country"] ?? "",
    phone = json["phone"] ?? "",
    roles = Set<String>.from(json["roles"] ?? []),
    language = json["language"] ?? "",
    birthday = parse(json["birthday"] ?? ""),
    isActivated = json["isActivated"] ?? false,
    wallet = (json["walletInfo"] != null) ? Wallet.fromJson(json["walletInfo"]) : null,
    requiredNote = json["requiredNote"] ?? "",
    isPhoneActivated = json["isPhoneActivated"] ?? false,
    timezone = json["timezone"] ?? 0,
    studySchedule = json["studySchedule"] ?? "",
    canSendMessage = json["canSendMessage"] ?? false;
}

DateTime parse(String str) {
  try {
    var parts = str.split("-");
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }
  catch (err) {
    return DateTime(0);
  }
}