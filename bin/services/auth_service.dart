import '../lib/auth_lib.dart';

abstract class AuthService {
  Future<AuthResult> validateLogin(String accessToken);
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl({required this.authLib});
  final AuthLib authLib;

  @override
  Future<AuthResult> validateLogin(String accessToken) async {
    return AuthResult.success;
  }
}

enum AuthResult { success, noUser, passInvalid }
