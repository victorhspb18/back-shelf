import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../controllers/users_controller.dart';
import '../infra/injection.dart';
import 'custom_api.dart';

class UserApi extends CustomApi {
  UserApi() {
    router = getIt();
  }

  late Router router;

  final UsersController controller = UsersController();

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    router.get('/users/<id>', (Request req, String? id) {
      return controller.getUser(id);
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
