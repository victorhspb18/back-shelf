import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

final getIt = GetIt.instance;

void boostrap(Router router) {
  getIt.registerSingleton<Router>(router);
}
