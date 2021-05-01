import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth;
  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }
  User getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<bool> login(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (error) {
      // print(error + 'AUTH_PROVIDER');
      // correo Invalido,
      // password incorrecto
      // no hay conexion a internet
      errorMessage = error.code;
      if (errorMessage != null)
        return Future.error('authProvider ' + errorMessage);
      return false;
    }
  }

  Future<void> register(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      // print(error + 'AUTH_PROVIDER');
      // correo Invalido,
      // password incorrecto
      // no hay conexion a internet
      errorMessage = error.code;
    }
    if (errorMessage != null)
      return Future.error('authProvider ' + errorMessage);
  }
}
