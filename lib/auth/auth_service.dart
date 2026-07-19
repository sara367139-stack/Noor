import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noorah/features/profile/pages/profile_service.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Current User
  User? get currentUser => _auth.currentUser;


  // Register
  Future<User?> register(
  String name,
  String email,
  String password,
) async {
  try {
    final result =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (result.user != null) {
      await ProfileService().createUserProfile(
        uid: result.user!.uid,
        name: name,
        email: email,
      );
    }

    return result.user;
  } on FirebaseAuthException catch (e) {
    throw e.message ?? "Register failed";
  }
}



  // Login
  Future<User?> login(
    String email,
    String password,
  ) async {

    try {

      final result =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;

    } on FirebaseAuthException catch (e) {

      throw e.message ?? "Login failed";

    }

  }



  // Logout
  Future<void> logout() async {

    await _auth.signOut();

  }

Stream<User?> get authStateChanges =>
    _auth.authStateChanges();
}