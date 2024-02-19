import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../infra/injection.dart';
import '../lib/user_lib.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UsersController {
  UsersController({UserService? userServiceMock}) {
    userService = userServiceMock ?? getIt();
  }

  late UserService userService;

  Future<Response> getUser(String? id) async {
    if (id == null) {
      return Response(422, body: 'Parametros inválidos');
    }

    final user = await userService.getUser(id);

    if (user != null) {
      return Response.ok(user.toJson());
    }
    return Response.notFound('Não encontrado');
  }

  Future<Response> addUser(Request req) async {
    final body = jsonDecode(await req.readAsString());

    final String? fullName = body['fullName'];
    final String? id = body['id'];
    final String? email = body['email'];

    if (fullName == null || id == null || email == null) {
      return Response(422, body: 'Parametros inválidos');
    }

    final user = await userService.saveUser(
      email: email,
      id: id,
      fullName: fullName,
    );
    if (user != null) {
      return Response(201, body: jsonEncode(user.toMap()));
    }

    return Response.badRequest(body: 'Erro ao cadastrar usuário');
  }
}
