import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../infra/security/security_service.dart';
import '../lib/auth_lib.dart';
import '../lib/user_lib.dart';

class AuthController {
  AuthController({
    AuthLib? authLibMock,
    UserLib? userLibMock,
    SecurityService? securityServiceMock,
  }) {
    authLib = authLibMock ?? AuthLib();
    userLib = userLibMock ?? UserLib();
    securityService = securityServiceMock ?? SecurityServiceImpl();
  }

  late AuthLib authLib;
  late UserLib userLib;
  late SecurityService securityService;

  Future<Response> login(Request req) async {
    final body = jsonDecode(await req.readAsString());
    final String? accessToken = body['accessToken'];

    if (accessToken == null) return Response(422, body: 'Parametros inválidos');

    final resultLogin = await authLib.validateLogin(accessToken);

    if (resultLogin == AuthResult.success) {
      final userData = await userLib.getUser('victor.hugo.barbosa');

      if (userData == null) {
        return Response(404, body: 'Usuário não encontrado');
      }
      final token = await securityService.generateJWT('victor.hugo.barbosa');
      userData.addAll({"token": token});
      return Response.ok(jsonEncode(userData));
    } else {
      return Response.badRequest();
    }
  }
}
