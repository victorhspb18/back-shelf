import '../infra/database/db_configuration.dart';

abstract class AuthLib {}

class AuthLibImpl implements AuthLib {
  AuthLibImpl({required this.dbConfiguration});
  final DbConfiguration dbConfiguration;
}
