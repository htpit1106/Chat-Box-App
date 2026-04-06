import 'package:chatbox/core/error/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

enum SignUpError { emailAlreadyInUse, invalidEmail, weakPassword, unknown }

abstract class AuthRepository {
  Future<UserCredential> signUp({
    required String email,
    required String password,
  });

  Future<void> logIn({required String email, required String password});

  Future<Either<Failure, void>> logout();

  bool isLoggedIn();
}

class AuthRepositoryImpl implements AuthRepository {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  @override
  Future<void> logIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  @override
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
