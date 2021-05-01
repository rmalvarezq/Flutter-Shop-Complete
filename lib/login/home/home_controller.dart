import 'package:flutter/material.dart';
import 'package:shopflutter/login/utils/shared_preference.dart';

class HomeController {
  BuildContext context;
  SharedPref _sharedPref;
  
  void init(BuildContext context) {
    this.context = context;
    _sharedPref = new SharedPref();
  }

  void goToLoginPage(String typeUser) {
    saveTypeUser(typeUser);
    Navigator.pushNamed(context, 'login');
  }

  void saveTypeUser(String typeUser) async {
    await _sharedPref.save('typeUser', typeUser);
  }
}
