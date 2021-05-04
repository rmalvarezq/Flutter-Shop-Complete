import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth;
  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return false;
    }
    return true;
  }

  void checkIfUserIsLogged(BuildContext context, String typeUser) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user != null && typeUser != null) {
        if (typeUser == 'client') {
          Navigator.pushNamedAndRemoveUntil(
              context, 'client/map', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, 'admin/map', (route) => false);
        }
        // el usuario está logeado
        print('LOGUEADO');
      } else {
        print('NO LOGUEADO');
      }
    });
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

  Future<bool> register(String email, String password) async {
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

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}
