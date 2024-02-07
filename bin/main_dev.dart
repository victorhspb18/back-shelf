import 'package:shelf/shelf.dart';

import 'apis/login_api.dart';
import 'apis/user_api.dart';
import 'infra/custom_serve.dart';
import 'services/user_service.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env_dev');

  final CustomServer customServer = CustomServer();

  final cascadeHandler =
      Cascade().add(LoginApi().handler).add(UserApi(UserService()).handler);

  var handler = const Pipeline().addMiddleware(logRequests()).addHandler(
        cascadeHandler.handler,
      );

  await customServer.initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_adress'),
    port: await CustomEnv.get<int>(key: 'port'),
  );
}
