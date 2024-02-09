import 'package:shelf_router/shelf_router.dart';
import 'infra/injection.dart';
import 'infra/pipeline.dart';
import 'utils/custom_env.dart';

Future<void> main() async {
  boostrap(Router());
  CustomEnv.fromFile('.env_dev');

  await initializePipeline();
}
