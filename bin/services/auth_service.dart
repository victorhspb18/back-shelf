import 'package:password_dart/password_dart.dart';

import '../lib/user_lib.dart';

abstract class AuthService {
  Future<AuthResult> validateLogin(String email, String password);
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl({required this.userLib});
  final UserLib userLib;

  @override
  Future<AuthResult> validateLogin(String email, String password) async {
    final user = await userLib.findOneByEmail(email);

    if (user == null) {
      return AuthResult.noUser;
    }

    if (Password.verify(password, user.password)) {
      return AuthResult.success;
    }

    return AuthResult.invalidPassword;
  }
}

enum AuthResult { success, noUser, invalidPassword }
