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

  // Fungsi pembantu untuk menerjemahkan error Firebase
  String _mapFirebaseError(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'Email tidak terdaftar.';
        case 'wrong-password':
          return 'Kata sandi salah.';
        case 'email-already-in-use':
          return 'Email sudah digunakan akun lain.';
        case 'invalid-email':
          return 'Format email tidak valid.';
        case 'weak-password':
          return 'Kata sandi terlalu lemah.';
        case 'user-disabled':
          return 'Akun ini telah dinonaktifkan.';
        default:
          return 'Terjadi kesalahan: ${e.message}';
      }
    }
    return 'Terjadi kesalahan koneksi.';
  }

  Future<String?> login(String email, String password) async {
    try {
      await _service.login(email, password);
      return null;
    } catch (e) {
      return _mapFirebaseError(e); // Gunakan pemetaan error
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      await _service.register(email, password);
      return null;
    } catch (e) {
      return _mapFirebaseError(e); // Gunakan pemetaan error
    }
  }

  Future<void> logout() => _service.logout();
}
