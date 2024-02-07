import '../lib/user_lib.dart';
import '../models/user_model.dart';
import 'generic_service.dart';

class UserService implements GenericService<UserModel> {
  final UserLib userDatasource = UserLib();

  @override
  Future<bool> delete(String id) async {
    await userDatasource.deleteUser(id);
    return true;
  }

  @override
  Future<UserModel?> findOne(String? id) async {
    final user = await userDatasource.getUser(id);
    return UserModel.fromMap(user);
  }

  @override
  Future<List<UserModel>> listAll() async {
    final users = await userDatasource.listAll();
    return users
        .map((e) => UserModel.fromMap(e))
        .toList()
        .removeWhere((u) => u == null) as List<UserModel>;
  }

  @override
  Future<UserModel> save(UserModel value) async {
    await userDatasource.addUser(value.toMap());
    return value;
  }
}
