import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'users_repository.dart';

class AuthRepository {
  AuthRepository({UsersRepository? userRepo}) {
    usersRepository = userRepo ?? UsersRepository();
  }

  late final UsersRepository usersRepository;

  Future<Response> login(Request req) async {
    try {
      final bodyReq =
          json.decode(await req.readAsString()) as Map<String, dynamic>?;

      if (bodyReq == null) {
        return Response(
          422,
          body: 'Parametros inválidos',
        );
      }

      final String? accessToken = bodyReq['accessToken'];

      if (accessToken == null) {
        return Response(
          422,
          body: 'Parametros inválidos',
        );
      }

      if (accessToken != '123') {
        final userResult = await usersRepository.getUserDataById('123');
        final body = await userResult.readAsString();

        return Response.ok(json.encode(json.decode(body)));
      }
      return Response(404, body: 'E-mail ou senha inválidos');
    } catch (e, s) {
      print(e);
      print(s);
      return Response(
        422,
        body: 'Erro interno',
      );
    }
  }
}
