import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../datasources/user_datasource.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UsersRepository {
  UsersRepository({UserService? service}) {
    userService = service ?? UserService();
  }

  late UserService userService;

  Future<Response> getUserDataById(String? id) async {
    try {
      if (id == null) return Response(422, body: 'Parametros inválidos');

      final UserModel? userData = await userService.findOne(id);
      if (userData == null) {
        return Response(404, body: 'Usuário não encontrado');
      }

      return Response(200, body: json.encode(userData.toMap()));
    } catch (e, s) {
      print('o erro foi aqui $s');

      return Response(500, body: 'Houve um erro');
    }
  }
}
