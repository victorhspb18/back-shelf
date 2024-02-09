import 'package:shelf/shelf.dart';

import '../apis/login_api.dart';
import '../apis/user_api.dart';
import '../utils/custom_env.dart';
import 'custom_serve.dart';
import 'injection.dart';
import 'middleware_interception.dart';
import 'security/security_service.dart';

Future<void> initializePipeline() async {
  final CustomServer customServer = CustomServer();
  final SecurityService securityService = getIt();

  final cascadeHandler = Cascade().add(LoginApi().getHandler()).add(
        UserApi().getHandler(middlewares: [
          securityService.authorization,
          securityService.verifyJWT
        ]),
      );

  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception.middleWare)
      .addHandler(
        cascadeHandler.handler,
      );

  await customServer.initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_adress'),
    port: await CustomEnv.get<int>(key: 'port'),
  );
}
