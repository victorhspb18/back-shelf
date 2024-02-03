import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../entities/user.dart';
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

      final String? user = bodyReq['user'];
      final String? pass = bodyReq['password'];

      if (user == null || pass == null) {
        return Response(
          422,
          body: 'Parametros inválidos',
        );
      }

      if (user == 'victor' && pass == '123') {
        final userResult = await usersRepository.getUserDataById('123');
        final body = await userResult.readAsString();
        final userLogged = User(name: json.decode(body)['fullName']);

        return Response.ok(json.encode(userLogged.toMap()));
      }
      return Response(404, body: 'E-mail ou senha inválidos');
    } catch (e, s) {
      print(e);
      print(s);
      return Response(
        422,
        body: 'Parametros inválidos',
      );
    }
  }
}
