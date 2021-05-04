import 'package:flutter/material.dart';
import 'package:shopflutter/login/providers/auth_provider.dart';
import 'package:shopflutter/login/utils/shared_preference.dart';

class HomeController {
  BuildContext context;
  SharedPref _sharedPref;

  AuthProvider _authProvider;
  String _typeUser;

  Future init(BuildContext context) async {
    this.context = context;
    _sharedPref = new SharedPref();
    _authProvider = new AuthProvider();
    _typeUser = await _sharedPref?.read('typeUser');
    _authProvider.checkIfUserIsLogged(context, _typeUser);
    checkIfUserIsAuth();
  }

  void checkIfUserIsAuth() {
    bool isSigned = _authProvider.isSignedIn();
    if (isSigned) {
      print('está Logueado');
      if (_typeUser == 'client') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'client/map', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, 'admin/map', (route) => false);
      }
    } else {
      print('No está Logueado');
    }
  }

  void goToLoginPage(String typeUser) {
    saveTypeUser(typeUser);
    Navigator.pushNamed(context, 'login');
  }

  void saveTypeUser(String typeUser) async {
    await _sharedPref.save('typeUser', typeUser);
  }
}
