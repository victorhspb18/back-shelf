import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../utils/custom_env.dart';

abstract class SecurityService<T> {
  Future<String> generateJWT(String userID);
  Future<T?> validateJWT(String token);
  Middleware get authorization;
  Middleware get verifyJWT;
}

class SecurityServiceImpl implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    final jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'userID': userID,
      'roles': ['admin'],
    });
    final String keySecret = await CustomEnv.get<String>(key: 'jwt_key');
    return jwt.sign(SecretKey(keySecret));
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    final String keySecret = await CustomEnv.get<String>(key: 'jwt_key');

    try {
      return JWT.verify(token, SecretKey(keySecret));
    } on JWTException catch (e) {
      return null;
      if (e is JWTInvalidException) {
      } else if (e is JWTExpiredException) {}
    } catch (e, s) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        final String? authorizationHeader = req.headers['Authorization'];

        JWT? jwt;
        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith('Bearer ')) {
            final token = authorizationHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }
        final request = req.change(context: {'jwt': jwt});
        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJWT => createMiddleware(
        requestHandler: (Request req) {
          if (req.context['jwt'] == null) return Response.forbidden('Negado');
          return null;
        },
      );
}

enum JwtError { invalid, expired }
