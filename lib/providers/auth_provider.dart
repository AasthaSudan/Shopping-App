import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ Expose auth state changes as a Stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Example: Sign in with email & password
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      print("SignIn Error: ${error.code} -> ${error.message}");
      throw error.message ?? "Something went wrong!";
    } catch (error) {
      print("Unexpected SignIn Error: $error");
      throw "Unexpected error occurred!";
    }
  }

  // Example: Sign up with email & password
  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      print("SignUp Error: ${error.code} -> ${error.message}");
      throw error.message ?? "Something went wrong!";
    } catch (error) {
      print("Unexpected SignUp Error: $error");
      throw "Unexpected error occurred!";
    }
  }

  // Example: Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ✅ Current user id
  String? get userId => _auth.currentUser?.uid;
}
