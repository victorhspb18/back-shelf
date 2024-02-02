import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as server_io;

import 'server_handler.dart';

void main() async {
  final ServerHanlder serverHanlder = ServerHanlder();

  final server = await server_io.serve(
    serverHanlder.handler,
    'localhost',
    8080,
  );

  print('Nosso servidor foi iniciado em ${server.port}');
}
