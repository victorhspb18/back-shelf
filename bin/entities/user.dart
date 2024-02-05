import 'dart:convert';

class User {
  User({
    required this.accessToken,
    required this.fullName,
    required this.eid,
    required this.email,
  });

  Map<String, dynamic> toMap(String data) {
    final body = json.decode(data);

    return {
      "accessToken": body["accessToken"],
      "fullName": body["fullName"],
      "eid": body["eid"],
      "email": body["email"],
    };
  }

  final String accessToken;
  final String fullName;
  final String eid;
  final String email;
}
