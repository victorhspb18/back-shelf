import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../services/generic_service.dart';

class UserApi {
  UserApi(this.service);
  final GenericService service;

  Handler get handler {
    final Router router = Router();

    router.get('/users/<id>', (Request req, String? id) async {
      final user = await service.findOne(id);
      if (user == null) Response.notFound('Não encontrado');
      return Response.ok(jsonEncode(user.toMap()));
    });

    return router;
  }
}
