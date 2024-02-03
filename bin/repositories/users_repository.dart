import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../datasources/user_datasource.dart';

class UsersRepository {
  UsersRepository({UserDatasource? datasource}) {
    userDatasource = datasource ?? UserDatasource();
  }

  late final UserDatasource userDatasource;

  Future<Response> getUserDataById(String? id) async {
    try {
      if (id == null) return Response(422, body: 'Parametros inválidos');

      final userData = await userDatasource.getUserDataAtBd(id.toString());

      if (userData == null) {
        return Response(404, body: 'Usuário não encontrado');
      }

      return Response(200, body: json.encode(userData));
    } catch (e) {
      return Response(500, body: 'Houve um erro');
    }
  }
}
