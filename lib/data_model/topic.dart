class Topic {
  String id;
  int orderCourse;
  String name;
  String nameFile;
  int numberOfPages;
  String description;
  String videoUrl;
  String type;
  DateTime createdAt;
  DateTime updatedAt;

  Topic.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? "",
    orderCourse = json["orderCourse"] ?? 0,
    name = json["name"],
    nameFile = json["nameFile"],
    numberOfPages = json["numberOfPages"] ?? 0,
    description = json["description"] ?? "",
    videoUrl = json["videoUrl"] ?? "",
    type = json["type"] ?? "",
    createdAt = DateTime.parse(json["createdAt"]),
    updatedAt = DateTime.parse(json["updatedAt"]);
}