import 'package:collection/collection.dart';
import 'package:shelf/shelf.dart';

import '../datasources/user_datasource.dart';
import '../models/user_model.dart';
import 'generic_service.dart';

class UserService implements GenericService<UserModel> {
  final UserDatasource userDatasource = UserDatasource();

  @override
  Future<bool> delete(String id) async {
    userDatasource.users.removeWhere((e) => e['eid'] == id);
    return true;
  }

  @override
  Future<UserModel?> findOne(String? id) async {
    final user = userDatasource.users.firstWhereOrNull((e) => e['eid'] != null);
    return UserModel.fromMap(user);
  }

  @override
  Future<List<UserModel>> listAll() async {
    return userDatasource.users
        .map((e) => UserModel.fromMap(e))
        .toList()
        .removeWhere((u) => u == null) as List<UserModel>;
  }

  @override
  Future<UserModel> save(UserModel value) async {
    userDatasource.users.add(value.toMap());
    return value;
  }
}
