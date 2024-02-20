import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../infra/injection.dart';
import '../models/user_model.dart';
import '../results/save_user_failed_result.dart';
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

    final user = await userService.getUserById(id);

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
    final String? password = body['password'];

    if (fullName == null || id == null || email == null || password == null) {
      return Response(422, body: 'Parametros inválidos');
    }

    final resultUser = await userService.saveUser(
      user: UserModel.create(
        email: email,
        id: id,
        fullName: fullName,
        password: password,
      ),
    );

    return resultUser.fold((error) {
      switch (error) {
        case SaveUserFailedResult.alreadyExists:
          return Response(
            409,
            body: 'Já existe um usuário para os dados informados',
          );
        case SaveUserFailedResult.internalError:
          return Response.badRequest(
            body: 'Houve um erro ao criar o usuário',
          );
      }
    }, (user) {
      return Response(201, body: jsonEncode(user.toMap()));
    });
  }
}
