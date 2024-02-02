import 'dart:convert';

import 'package:shelf/shelf.dart';

class UsersRepository {
  Future<Response> getUserDataById(String? id) async {
    try {
      if (id == null) return Response(422, body: 'Parametros inválidos');

      final userData = await _getUserDataAtBd(id.toString());

      if (userData == null) {
        return Response(404, body: 'Usuário não encontrado');
      }

      return Response(200, body: json.encode(userData));
    } catch (e) {
      return Response(500, body: 'Houve um erro');
    }
  }

  Future<Map<String, dynamic>?> _getUserDataAtBd(String id) async {
    await Future.delayed(Duration(seconds: 1));

    if (id == '123') {
      return {
        "shortName": "Victor Hugo",
        "fullName": "Victor Hugo Silva Pereira Barbosa",
        "idade": "22",
      };
    }
    return null;
  }
}
