import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class AuthService {
  static const _baseUrl = 'dummyjson.com';
  final http.Client _client;

  AuthService([http.Client? client]) : _client = client ?? http.Client();

  Future<User> login({required String username, required String password}) async {
    final uri = Uri.https(_baseUrl, '/auth/login');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final message = body['message'] as String? ?? 'Credenciais inválidas';
      throw Exception(message);
    }

    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
