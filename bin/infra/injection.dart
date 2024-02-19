import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../lib/auth_lib.dart';
import '../lib/user_lib.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import 'database/db_configuration.dart';
import 'database/mysql_db_configuration.dart';
import 'security/security_service.dart';

final getIt = GetIt.instance;

void boostrap(Router router) {
  getIt.registerSingleton<Router>(router);
  getIt.registerSingleton<DbConfiguration>(MysqlDbConfiguration());

  getIt.registerSingleton<AuthLib>(AuthLibImpl(
    dbConfiguration: getIt<DbConfiguration>(),
  ));
  getIt.registerFactory<AuthService>(
    () => AuthServiceImpl(authLib: getIt<AuthLib>()),
  );

  getIt.registerSingleton(UserLib(getIt<DbConfiguration>()));
  getIt.registerFactory<UserService>(
    () => UserServiceImpl(userLib: getIt<UserLib>()),
  );

  getIt.registerSingleton<SecurityService>(SecurityServiceImpl());
}
