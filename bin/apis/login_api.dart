import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../repositories/auth_repository.dart';

class LoginApi {
  final AuthRepository authRepository = AuthRepository();

  Handler get handler {
    final router = Router();

    router.post('/login', (Request req) {
      return authRepository.login(req);
    });

    return router;
  }
}
