import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as server_io;

void main() async {
  final server = await server_io.serve(
    (request) => Response(200, body: 'ok'),
    'localhost',
    8080,
  );

  print('Nosso servido foi iniciado http://localhost:8080');
}
