import 'package:mysql1/mysql1.dart';

import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import '../lib/dao.dart';

class UserLib implements Dao<UserModel> {
  UserLib(this._dbConfiguration);
  final DbConfiguration _dbConfiguration;

  @override
  Future<UserModel?> create(UserModel user) async {
    try {
      final sql = "INSERT INTO users (id, name, email) "
          "VALUES ('${user.id}', '${user.fullName}', '${user.email}')";

      final connection = await _dbConfiguration.connection;
      connection as MySqlConnection;
      print(connection);

      await connection.query(sql);

      return user;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      final sql = "DELETE FROM users WHERE id = '$id'";

      final connection = await _dbConfiguration.connection;

      await connection.query(sql);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<UserModel>> findAll() async {
    try {
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
    } catch (e) {
      throw Exception('Erro ao listar usuários');
    }
  }

  @override
  Future<UserModel?> findOne(String id) async {
    try {
      final String sql = "SELECT * FROM users where id = '$id'";
      final connection = await _dbConfiguration.connection;
      final result = await connection.query(sql);

      UserModel? user;

      for (final u in result) {
        user = UserModel.fromMap(u);
      }

      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel?> update(UserModel user) async {
    try {
      final String sql = "UPDATE users set fullName = '${user.fullName}', "
          "email = '${user.email}'";
      final connection = await _dbConfiguration.connection;
      await connection.query(sql);

      return user;
    } catch (e) {
      throw Exception('Erro ao atualizar usuários');
    }
  }
}
