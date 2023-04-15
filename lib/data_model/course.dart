import 'package:let_tutor/data_model/topic.dart';
import 'package:let_tutor/utils/utils.dart';

class Course {
  static const levelStrings = [
    "Any level",
    "Beginner",
    "Upper-Beginner",
    "Pre-Intermediate",
    "Intermediate",
    "Upper-Intermediate",
    "Pre-Advanced",
    "Advanced",
    "Very-Advanced"
  ];

  String id;
  String name;
  String description;
  String imageUrl;
  int leveNumber;
  String reason;
  String purpose;
  String otherDetails;
  int defaultPrice;
  int coursePrice;
  String courseType;
  String sectionType;
  bool visible;
  String displayOrder;
  DateTime createdAt;
  DateTime updatedAt;
  List<Topic> topics;
  String category;

  Course.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? "",
    name = json["name"] ?? "",
    description = json["description"] ?? "",
    imageUrl = json["imageUrl"] ?? "",
    leveNumber = (json["level"] == null) ? 0 : int.parse(json["level"]),
    reason = json["reason"] ?? "",
    purpose = json["purpose"] ?? "",
    otherDetails = json["other_details"] ?? "",
    defaultPrice = json["default_price"] ?? 0,
    coursePrice = json["course_price"] ?? 0,
    courseType = json["courseType"] ?? "",
    sectionType = json["sectionType"] ?? "",
    visible = json["visible"] ?? false,
    displayOrder = json["displayOrder"] ?? "",
    createdAt = DateTime.parse(json["createdAt"] ?? json["TutorCourse"]["createdAt"]),
    updatedAt = DateTime.parse(json["updatedAt"] ?? json["TutorCourse"]["updatedAt"]),
    topics = (json["topics"] == null) ? [] : (json["topics"] as List).toNewList((json) => Topic.fromJson(json)),
    category = (json["categories"] != null) ? json["categories"][0]["title"] : "";

  String get level => levelStrings[leveNumber];
}