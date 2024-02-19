import 'dart:convert';

class UserModel {
  UserModel({
    required this.fullName,
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updateAt,
  });

  static UserModel? fromMap(Map<String, dynamic>? data) {
    if (data == null) return null;
    return UserModel(
      fullName: data['fullName'],
      id: data['id'],
      email: data['email'],
      createdAt: DateTime.tryParse(data['createAt']),
      updateAt: DateTime.tryParse(data['updateAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "accessToken": accessToken,
      "fullName": fullName,
      "id": id,
      "email": email,
      "createdAt": createdAt?.toIso8601String(),
      "updateAt": updateAt?.toIso8601String(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  String accessToken = '';
  final String fullName;
  final String id;
  final String email;
  final DateTime? createdAt;
  final DateTime? updateAt;
}
