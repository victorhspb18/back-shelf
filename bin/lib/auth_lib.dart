class AuthLib {
  Future<AuthResult> validateLogin(String accessToken) async {
    return AuthResult.success;
  }
}

enum AuthResult { success, noUser, passInvalid }
