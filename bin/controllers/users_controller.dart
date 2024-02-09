import 'package:shelf/shelf.dart';

import '../services/user_service.dart';

class UsersController {
  UsersController({UserService? userServiceMock}) {
    userService = userServiceMock ?? UserService();
  }

  late UserService userService;

  Future<Response> getUser(String? id) async {
    final user = await userService.findOne(id);

    if (user != null) {
      return Response.ok(user.toJson());
    }
    return Response.notFound('Não encontrado');
  }
}
