import 'package:mysql1/mysql1.dart';

import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import '../lib/dao.dart';

class UserLib implements Dao<UserModel> {
  UserLib(this._dbConfiguration);
  final DbConfiguration _dbConfiguration;

  @override
  Future<bool> create(UserModel user) async {
    final sql = "INSERT INTO users (id, fullName, email, password) "
        "VALUES (?, ?, ?, ?)";

    final connection = await _dbConfiguration.connection;
    connection as MySqlConnection;
    print(connection);

    await connection.query(sql, [
      user.id,
      user.fullName,
      user.email,
      user.password,
    ]);

    return true;
  }

  @override
  Future<bool> delete(String id) async {
    final sql = "DELETE FROM users WHERE id = '$id'";

    final connection = await _dbConfiguration.connection;

    await connection.query(sql);

    return true;
  }

  @override
  Future<List<UserModel>> findAll() async {
    final String sql = "SELECT * FROM users";
    final connection = await _dbConfiguration.connection;
    final result = await connection.query(sql);

    final usersResult = (result as List).map((e) {
      return UserModel.fromMap(e);
    }).toList();

    final List<UserModel> usersFiltered = [];
    for (final u in usersResult) {
      if (u != null) usersFiltered.add(u);
    }

    return usersFiltered;
  }

  @override
  Future<UserModel?> findOne(String id) async {
    final String sql = "SELECT * FROM users where id = '$id'";
    final connection = await _dbConfiguration.connection;
    final result = await connection.query(sql);

    UserModel? user;

    for (final u in result) {
      user = UserModel.fromMap(u.fields);
    }

    return user;
  }

  Future<UserModel?> findOneByEmail(String email) async {
    final String sql = "SELECT * FROM users where email = '$email'";
    final connection = await _dbConfiguration.connection;
    final result = await connection.query(sql);

    UserModel? user;

    for (final u in result) {
      user = UserModel.fromMap(u.fields);
    }

    return user;
  }

  @override
  Future<bool> update(UserModel user) async {
    final String sql = "UPDATE users set fullName = '${user.fullName}', "
        "email = '${user.email}'";
    final connection = await _dbConfiguration.connection;
    await connection.query(sql);

    return true;
  }
}
