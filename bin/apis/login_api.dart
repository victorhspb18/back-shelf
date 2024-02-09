import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../controllers/auth_controller.dart';
import '../infra/injection.dart';
import 'custom_api.dart';

class LoginApi extends CustomApi {
  LoginApi() {
    router = getIt();
  }
  late Router router;

  final AuthController controller = AuthController();

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    router.post('/login', (Request req) {
      return controller.login(req);
    });

    return createHandler(router: router);
  }
}
