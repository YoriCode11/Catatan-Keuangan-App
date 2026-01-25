import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  User? user;

  AuthProvider() {
    _service.authStateChanges().listen((u) {
      user = u;
      notifyListeners();
    });
  }

  Future<String?> login(String email, String password) async {
    try {
      await _service.login(email, password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      await _service.register(email, password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() => _service.logout();
}
