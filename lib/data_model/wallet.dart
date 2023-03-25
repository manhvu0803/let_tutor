class Wallet {
  String id = "";
  int amount = 0;
  bool isBlocked = true;
  final DateTime createdAt;
  DateTime updatedAt = DateTime(0);
  int bonus = 0;

  Wallet({required this.createdAt});

  Wallet.fromJson(Map<String, dynamic> json) :
    id = json["id"],
    amount = int.parse(json["amount"]),
    isBlocked = json["isBlocked"],
    createdAt = DateTime.parse(json["createdAt"]),
    updatedAt = DateTime.parse(json["updatedAt"]),
    bonus = json["bonus"];
}