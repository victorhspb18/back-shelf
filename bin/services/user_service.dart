import '../lib/user_lib.dart';
import '../models/user_model.dart';

abstract class UserService {
  Future<UserModel?> getUser(String id);
  Future<UserModel?> saveUser({
    required String id,
    required String email,
    required String fullName,
  });
}

class UserServiceImpl implements UserService {
  UserServiceImpl({required this.userLib});
  final UserLib userLib;

  @override
  Future<UserModel?> getUser(String id) async {
    final user = await userLib.findOne(id);
    return user;
  }

  @override
  Future<UserModel?> saveUser({
    required String id,
    required String email,
    required String fullName,
  }) {
    final now = DateTime.now();
    return userLib.create(UserModel(
      fullName: fullName,
      id: id,
      email: email,
      createdAt: now,
      updateAt: now,
    ));
  }
}
