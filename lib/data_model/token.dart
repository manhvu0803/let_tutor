class Token {
  final String value;
  final DateTime expires;

  const Token(this.value, {required this.expires});

  Token.fromJson(Map<String, dynamic> json) :
    value = json["token"],
    expires = DateTime.parse(json["expires"]);

  @override
  String toString() {
    return "Token: $value\nExpire: $expires";
  }
}