import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'repositories/auth_repository.dart';
import 'repositories/users_repository.dart';

class ServerHanlder {
  Handler get handler {
    final router = Router();
    final usersRepository = UsersRepository();
    final authRepository = AuthRepository();

    router.get('/users/<id>', (Request req, String? id) {
      return usersRepository.getUserDataById(id);
    });

    router.post('/login', (Request req) {
      return authRepository.login(req);
    });

    return router;
  }
}
