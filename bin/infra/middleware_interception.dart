import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  static Middleware get middleWare {
    return createMiddleware(responseHandler: (Response req) {
      req.change(headers: {'content-type': 'application/json'});
      return req;
    });
  }
}
