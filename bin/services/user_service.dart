import 'package:password_dart/password_dart.dart';

import '../lib/user_lib.dart';
import '../models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../results/save_user_failed_result.dart';

abstract class UserService {
  Future<UserModel?> getUserById(String email);
  Future<UserModel?> getUserByEmail(String email);
  Future<Either<SaveUserFailedResult, UserModel>> saveUser({
    required UserModel user,
  });
}

class UserServiceImpl implements UserService {
  UserServiceImpl({required this.userLib});
  final UserLib userLib;

  @override
  Future<UserModel?> getUserById(String email) async {
    final user = await userLib.findOne(email);
    return user;
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    final user = await userLib.findOneByEmail(email);
    return user;
  }

  @override
  Future<Either<SaveUserFailedResult, UserModel>> saveUser({
    required UserModel user,
  }) async {
    try {
      final userAlreadyExists = await userLib.findOne(user.email);

      if (userAlreadyExists != null) {
        return Left(SaveUserFailedResult.alreadyExists);
      }

      await userLib.create(UserModel.create(
        fullName: user.fullName,
        id: user.id,
        email: user.email,
        password: Password.hash(user.password, PBKDF2()),
      ));

      final userCreated = await userLib.findOne(user.id);

      return Right(userCreated!);
    } catch (e) {
      print(e);
      if (e.toString().contains('Duplicate entry')) {
        return Left(SaveUserFailedResult.alreadyExists);
      }
      return Left(SaveUserFailedResult.internalError);
    }
  }
}
