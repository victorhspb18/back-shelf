import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/injection.dart';

abstract class CustomApi {
  Handler getHandler();

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];

    final Router router = getIt();

    final pipe = Pipeline();

    for (final m in middlewares) {
      pipe.addMiddleware(m);
    }

    return pipe.addHandler(router);
  }
}
