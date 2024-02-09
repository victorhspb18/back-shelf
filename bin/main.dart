import 'package:shelf_router/shelf_router.dart';

import 'infra/injection.dart';
import 'infra/pipeline.dart';
import 'utils/custom_env.dart';

void main() async {
  boostrap(Router());
  CustomEnv.fromFile('.env');

  await initializePipeline();
}
