import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;

  String? get userId => _userId;
  bool get isAuth => _userId != null;

  // Dummy user credentials
  final String _storedEmail = 'user@example.com';
  final String _storedPassword = 'password123';

  // Method to simulate sign up
  Future<void> signUp(String email, String password) async {
    if (email == _storedEmail && password == _storedPassword) {
      _userId = email;
      notifyListeners();
    } else {
      throw 'Invalid credentials!';
    }
  }

  // Method to simulate sign in
  Future<void> signIn(String email, String password) async {
    if (email == _storedEmail && password == _storedPassword) {
      _userId = email;
      notifyListeners();
    } else {
      throw 'Invalid credentials!';
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    _userId = null;
    notifyListeners();
  }
}
