import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../controllers/auth_controller.dart';
import '../infra/injection.dart';

class LoginApi {
  LoginApi() {
    router = getIt();
  }
  late Router router;

  final AuthController authRepository = AuthController();

  Handler get handler {
    router.post('/login', (Request req) {
      return authRepository.login(req);
    });

    return router;
  }
}
