import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum SignUpError { emailAlreadyInUse, invalidEmail, weakPassword, unknown }

abstract class AuthRepository {
  Future<UserCredential> signUp({required String email, required String password});
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserCredential> signUp({required String email, required String password}) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }
}
