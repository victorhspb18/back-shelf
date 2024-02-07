class UserModel {
  UserModel({
    required this.accessToken,
    required this.fullName,
    required this.eid,
    required this.email,
  });

  static UserModel? fromMap(Map<String, dynamic>? data) {
    if (data == null) return null;
    return UserModel(
      accessToken: data['accessToken'],
      fullName: data['fullName'],
      eid: data['eid'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "accessToken": accessToken,
      "fullName": fullName,
      "eid": eid,
      "email": email,
    };
  }

  final String accessToken;
  final String fullName;
  final String eid;
  final String email;
}
