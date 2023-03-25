import 'wallet.dart';

class User {
  String id = "";
  String email = "";
  String name = "";
  Uri avatarUrl = Uri.parse("");
  String country = "";
  String phone = "";
  Set<String> roles = {};
  String language = "";
  DateTime birthday = DateTime(0);
  bool isActivated = false;
  Wallet wallet;
  String requiredNote = "";
  String level = "";
  bool isPhoneActivated = false;
  int timezone = 0;
  String studySchedule = "";
  bool canSendMessage = false;

  User({required this.wallet});

  User.fromJson(Map<String, dynamic> json) :
    id = json["id"],
    email = json["email"],
    name = json["name"],
    avatarUrl = Uri.parse(json["avatar"]),
    country = json["country"],
    phone = json["phone"],
    roles = Set<String>.from(json["roles"]),
    language = json["language"] ?? "",
    birthday = DateTime.parse(json["birthday"]),
    isActivated = json["isActivated"],
    wallet = Wallet.fromJson(json["walletInfo"]),
    requiredNote = json["requiredNote"] ?? "",
    isPhoneActivated = json["isPhoneActivated"],
    timezone = json["timezone"],
    studySchedule = json["studySchedule"],
    canSendMessage = json["canSendMessage"];
}