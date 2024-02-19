import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../infra/injection.dart';
import '../infra/security/security_service.dart';
import '../lib/auth_lib.dart';
import '../lib/user_lib.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthController {
  AuthController({
    AuthService? authServiceMock,
    UserLib? userLibMock,
    SecurityService? securityServiceMock,
  }) {
    authService = authServiceMock ?? getIt();
    userLib = userLibMock ?? getIt();
    securityService = securityServiceMock ?? SecurityServiceImpl();
  }

  late AuthService authService;
  late UserLib userLib;
  late SecurityService securityService;

  Future<Response> login(Request req) async {
    final body = jsonDecode(await req.readAsString());
    final String? accessToken = body['accessToken'];

    if (accessToken == null) return Response(422, body: 'Parametros inválidos');

    final resultLogin = await authService.validateLogin(accessToken);

    if (resultLogin == AuthResult.success) {
      // TODO: BUSCAR PELO ID RETORNADO NO SERVICE
      final UserModel? userData = await userLib.findOne('victor.hugo.barbosa');

      if (userData == null) {
        return Response(404, body: 'Usuário não encontrado');
      }
      final token = await securityService.generateJWT('victor.hugo.barbosa');
      userData.accessToken = token;
      return Response.ok(userData.toMap());
    } else {
      return Response.badRequest();
    }
  }
}
