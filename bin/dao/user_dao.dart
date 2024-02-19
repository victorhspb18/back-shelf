import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import '../lib/dao.dart';

class UserDao implements Dao<UserModel> {
  UserDao(this._dbConfiguration);
  final DbConfiguration _dbConfiguration;

  @override
  Future<UserModel> create(UserModel value) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> findAll() async {
    final String sql = 'SELECT * FROM usuarios';
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
  Future<UserModel> findOne(String id) async {
    // TODO: implement findOne
    throw UnimplementedError();
  }

  @override
  Future<UserModel> update(UserModel value) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
