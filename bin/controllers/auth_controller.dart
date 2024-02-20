import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../infra/injection.dart';
import '../infra/security/security_service.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class AuthController {
  AuthController({
    AuthService? authServiceMock,
    UserService? userServiceMock,
    SecurityService? securityServiceMock,
  }) {
    authService = authServiceMock ?? getIt();
    userService = userServiceMock ?? getIt();
    securityService = securityServiceMock ?? SecurityServiceImpl();
  }

  late AuthService authService;
  late UserService userService;
  late SecurityService securityService;

  Future<Response> login(Request req) async {
    final body = jsonDecode(await req.readAsString());
    final String? email = body['email'];
    final String? password = body['password'];

    if (email == null || password == null) {
      return Response(422, body: 'Parametros inválidos');
    }

    final resultLogin = await authService.validateLogin(email, password);

    if (resultLogin == AuthResult.success) {
      final UserModel? userData = await userService.getUserByEmail(email);

      if (userData == null) {
        return Response(404, body: 'Usuário não encontrado');
      }
      final token = await securityService.generateJWT(userData.id);
      return Response.ok(jsonEncode({
        "userData": userData.toMap(),
        "accessToken": token,
      }));
    } else {
      return Response.forbidden('Usuário ou senha incorreta');
    }
  }
}
