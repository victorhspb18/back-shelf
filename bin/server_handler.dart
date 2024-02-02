import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'repositories/users_repository.dart';

class ServerHanlder {
  Handler get handler {
    final router = Router();
    final usersRepository = UsersRepository();

    router.get('/users', (Request request) {
      return usersRepository.getUserDataById(request.url.queryParameters['id']);
    });
    return router;
  }
}
