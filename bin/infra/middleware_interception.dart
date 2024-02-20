import 'package:shelf/shelf.dart';

class MInterception {
  static Middleware get contentTypeJson {
    return createMiddleware(
      responseHandler: (Response req) async {
        return req.change(headers: {'content-type': 'application/json'});
      },
    );
  }

  static Middleware get cors {
    final allowHeaders = {"Access-Control-Allow-Origin": "*"};

    Response? handlerOptions(Request req) {
      if (req.method == "OPTIONS") {
        return Response(200, headers: allowHeaders);
      }
      return null;
    }

    Response addCorsHeaders(Response res) => res.change(headers: allowHeaders);

    return createMiddleware(
      requestHandler: handlerOptions,
      responseHandler: addCorsHeaders,
    );
  }
}
