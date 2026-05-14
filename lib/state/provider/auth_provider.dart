import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service;
  User? _user;
  bool isLoading = false;
  String? error;

  AuthProvider([AuthService? service]) : _service = service ?? AuthService();

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> login(String username, String password) async {
    if (isLoading) return;
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final authenticated = await _service.login(username: username, password: password);
      _user = authenticated;
    } catch (e) {
      error = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    error = null;
    notifyListeners();
  }
}
