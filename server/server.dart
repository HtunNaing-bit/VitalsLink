import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main(List<String> args) async {
  final router = Router()..post('/api/ai/chat', _chatHandler);

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_cors())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  stdout.writeln(
    'Mock API running on http://${server.address.host}:${server.port}',
  );
}

Future<Response> _chatHandler(Request request) async {
  final body = await request.readAsString();
  final data = jsonDecode(body) as Map<String, dynamic>;
  final message = data['message'] as String? ?? '';
  final response = {
    'id': DateTime.now().millisecondsSinceEpoch.toString(),
    'role': 'assistant',
    'content':
        'AI Coach prototype: "$message" received. I recommend a 7pm dinner, 10pm wind-down, and hydration loop.',
    'timestamp': DateTime.now().toIso8601String(),
  };
  return Response.ok(
    jsonEncode(response),
    headers: {'Content-Type': 'application/json'},
  );
}

Middleware _cors() {
  return (Handler handler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: _corsHeaders);
      }
      final response = await handler(request);
      return response.change(headers: {...response.headers, ..._corsHeaders});
    };
  };
}

const _corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
};
