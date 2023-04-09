final categorieStrings = [
  "all",
  "english-for-kids",
  "business-english",
  "conversational-english",
  "starters",
  "movers",
  "flyers",
  "ket",
  "ielts",
  "toefl",
  "toeic",
];

class Category {
  String id;
  String title;
  String key;

  Category.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? "",
    title = json["title"] ?? "",
    key = json["key"] ?? "";
}