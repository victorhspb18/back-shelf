import 'package:collection/collection.dart';

class UserLib {
  final List<Map<String, dynamic>> _users = [
    {
      "accessToken": 'p1o28918201021',
      "fullName": 'Victor Hugo Silva Pereira Barbosa',
      "eid": 'victor.hugo.barbosa',
      "email": 'victor.hugo.barbosa@accenture.com',
    },
  ];

  Future<Map<String, dynamic>?> getUser(String? id) async {
    return _users.firstWhereOrNull((e) => e['eid'] == id);
  }

  Future<void> addUser(Map<String, dynamic> data) async {
    _users.add(data);
  }

  Future<List<Map<String, dynamic>>> listAll() async {
    return List.from(_users);
  }

  Future<void> deleteUser(String eid) async {
    _users.removeWhere((e) => e['ei'] == eid);
  }
}
