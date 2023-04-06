import '../utils.dart';
import 'topic.dart';

class Course {
  String id;
  String name;
  String description;
  String imageUrl;
  int level;
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

  Course.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? "",
    name = json["name"] ?? "",
    description = json["description"] ?? "",
    imageUrl = json["imageUrl"] ?? "",
    level = (json["level"] == null) ? 0 : int.parse(json["level"]),
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
    topics = (json["topics"] == null) ? [] : buildList(json["topics"], (dynamic json) => Topic.fromJson(json));
}