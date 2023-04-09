class StudentReview {
  String id;
  DateTime createdAt;
  String studentName;
  String studentAvatarUrl;
  int rating;
  String content;

  StudentReview.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? "",
    createdAt = DateTime.tryParse(json["createdAt"]) ?? DateTime(0),
    studentName = json["firstInfo"]["name"] ?? "",
    studentAvatarUrl = json["firstInfo"]["avatar"] ?? "",
    rating = json["rating"] ?? 0,
    content = json["content"] ?? "";
}