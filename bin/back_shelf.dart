import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as server_io;

void main() async {
  final server = await server_io.serve(
    (request) {
      if (request.url.path.contains('80')) {
        return Response(200, body: 'ok');
      }
      return Response(404, body: 'Nada encontrado');
    },
    'localhost',
    8080,
  );

  print('Nosso servidor foi iniciado em ${server.port}');
}
