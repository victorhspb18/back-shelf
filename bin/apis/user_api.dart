import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../controllers/users_controller.dart';
import '../infra/injection.dart';

class UserApi {
  UserApi() {
    router = getIt();
  }

  late Router router;

  final UsersController controller = UsersController();

  Handler get handler {
    router.get('/users/<id>', (Request req, String? id) {
      return controller.getUser(id);
    });

    return router;
  }
}
