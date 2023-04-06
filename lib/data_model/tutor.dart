import '../utils.dart';
import 'course.dart';
import 'user.dart';

class Tutor extends User {
  static List<Course> _getCourses(Map<String, dynamic> json) {
    var userData = json["User"] ?? json["user"];

    if (userData == null) {
      return [];
    }

    return buildList(userData["courses"], (dynamic json) => Course.fromJson(json));
  }

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
  List<Course> courses;

  Tutor.fromJson(Map<String, dynamic> json) :
    bio = json["bio"] ?? "",
    videoUrl = json["video"] ?? "",
    education = json["education"] ?? "",
    experience = json["experience"] ?? "",
    accent = json["accent"] ?? "",
    targetStudent = json["targetStudent"] ?? "",
    interests = json["interests"] ?? "",
    languages = json["languages"] ?? "",
    specialties = (json["specialties"] == null) ? [] : (json["specialties"] as String).split(","),
    rating = json["rating"] ?? 0,
    isNative = json["isNative"] ?? false,
    isFavorite = json["isFavorite"] ?? false,
    totalFeedbacks = json["totalFeedbacks"] ?? 0,
    courses = _getCourses(json),
    super.fromJson(json["User"] ?? json["user"] ?? json);
}