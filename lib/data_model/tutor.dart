import 'user.dart';

class Tutor extends User {
  String bio;
  String videoUrl;
  String education;
  String experience;
  String accent;
  String targetStudent;
  String interests;
  String languages;
  List<String> specialties;
  double rating;
  bool isNative;
  bool isFavorite;
  int totalFeedbacks;

  Tutor.fromJson(Map<String, dynamic> json) :
    bio = json["bio"],
    videoUrl = json["video"],
    education = json["education"],
    experience = json["experience"],
    accent = json["accent"] ?? "",
    targetStudent = json["targetStudent"],
    interests = json["interests"],
    languages = json["languages"] ?? "",
    specialties = (json["specialties"] as String).split(","),
    rating = json["rating"],
    isNative = json["isNative"] ?? false,
    isFavorite = json["isFavorite"] ?? false,
    totalFeedbacks = json["totalFeedbacks"] ?? 0,
    super.fromJson(json["User"] ?? json ["user"]);
}