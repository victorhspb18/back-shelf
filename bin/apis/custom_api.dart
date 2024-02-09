import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/injection.dart';
import '../infra/security/security_service.dart';

abstract class CustomApi {
  Handler getHandler();

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    middlewares ??= [];

    final Router router = getIt();

    final pipe = Pipeline();

    for (final m in middlewares) {
      pipe.addMiddleware(m);
    }

    if (isSecurity) {
      final SecurityService securityService = getIt();
      middlewares.addAll([
        securityService.authorization,
        securityService.verifyJWT,
      ]);
    }

    return pipe.addHandler(router);
  }
}
