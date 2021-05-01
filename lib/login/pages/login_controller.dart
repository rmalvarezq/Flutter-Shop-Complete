import 'package:flutter/material.dart';
import 'package:shopflutter/login/providers/auth_provider.dart';
// import 'package:mapas_gps_flutter/login/utils/my_progress_dialog.dart';
import 'package:shopflutter/login/utils/shared_preference.dart';
import 'package:shopflutter/login/utils/snackbar.dart' as utils;
// import 'package:progress_dialog/progress_dialog.dart';

class LoginController {
  BuildContext context;

  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider _authProvider;
  // ProgressDialog _progressDialog;
  SharedPref _sharedPref;
  String _typeUser;
  bool isLogin = false;
  void init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
    // _progressDialog =
    //     MyProgressDialog.createProgressDialog(context, 'espere un momento');
    _sharedPref = new SharedPref();
    _typeUser = await _sharedPref.read('typeUser');
    print('*********=> $_typeUser');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      utils.Snackbar.showSnackbar(
          context, key, 'Llene todos los campos', Colors.red);
    }
    // _progressDialog.show();
    try {
      bool isLogin = await _authProvider.login(email, password);
      // await _authProvider.login(email, password);
      if (isLogin) {
        print('Logueado');
        print(isLogin);
        Navigator.pushNamed(context, 'login/private');
      }
      Navigator.pushNamed(context, 'login/private');
      // utils.Snackbar.showSnackbar(
      //     context, key, 'Registro exitoso', Colors.green);
      // _progressDialog.hide();
    } catch (error) {
      // print('NOT LOGGED');
      utils.Snackbar.showSnackbar(context, key,
          'Comuniquese con el administrador. Error: $error', Colors.red);
      print('ERROR $error ');
      // _progressDialog.hide();
      if (isLogin == false) {
        print('No logueado');
        Navigator.pushNamed(context, 'login');
      }
    }
    // _progressDialog.hide();
  }

  void goToRegisterPage() {
    if (_typeUser == 'client') {
      Navigator.pushNamed(context, 'client/register');
    } else {
      Navigator.pushNamed(context, 'admin/register');
    }
  }
}
