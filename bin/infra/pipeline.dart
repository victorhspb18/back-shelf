import 'package:shelf/shelf.dart';

import '../apis/login_api.dart';
import '../apis/user_api.dart';
import '../utils/custom_env.dart';
import 'custom_serve.dart';
import 'middleware_interception.dart';

Future<void> initializePipeline() async {
  final CustomServer customServer = CustomServer();
  final cascadeHandler = Cascade().add(LoginApi().getHandler()).add(
        UserApi().getHandler(
          isSecurity: true,
        ),
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
