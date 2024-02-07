import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as server_io;

class CustomServer {
  Future<void> initialize({
    required FutureOr<Response> Function(Request) handler,
    required String address,
    required int port,
  }) async {
    final server = await server_io.serve(
      handler,
      address,
      port,
    );

    print('Servidor iniciado em ${server.address.address}:${server.port}');
  }
}
