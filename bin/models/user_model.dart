import 'dart:convert';

class UserModel {
  UserModel.create({
    required this.fullName,
    required this.id,
    required this.email,
    required this.password,
  });

  UserModel.getFromDataBase({
    required this.fullName,
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updateAt,
    required this.password,
  });

  static UserModel? fromMap(Map<String, dynamic>? data) {
    if (data == null) return null;

    return UserModel.getFromDataBase(
      fullName: data['fullName'],
      id: data['id'],
      email: data['email'],
      createdAt: data['createdAt'],
      updateAt: data['updatedAt'],
      password: data['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
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

  final String fullName;
  final String id;
  final String email;
  final String password;

  DateTime? createdAt;
  DateTime? updateAt;
}
