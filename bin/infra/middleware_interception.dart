import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  static Middleware get middleWare {
    return createMiddleware(
      responseHandler: (Response req) async {
        return req.change(headers: {'content-type': 'application/json'});
      },
    );
  }
}
