import 'package:flutter/material.dart';
import 'package:shopflutter/login/models/admin.dart';
import 'package:shopflutter/login/models/client.dart';
import 'package:shopflutter/login/providers/admin_provider.dart';
import 'package:shopflutter/login/providers/auth_provider.dart';
import 'package:shopflutter/login/providers/client_provider.dart';
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
  AdminProvider _adminProvider;
  ClientProvider _clientProvider;

  SharedPref _sharedPref;
  String _typeUser;
  bool isLogin = false;
  void init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
    // _progressDialog =
    //     MyProgressDialog.createProgressDialog(context, 'espere un momento');
    _adminProvider = new AdminProvider();
    _clientProvider = new ClientProvider();
    _sharedPref = new SharedPref();
    _typeUser = await _sharedPref.read('typeUser');

    // print('*********=> $_typeUser');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      utils.Snackbar.showSnackbar(
          context, key, 'Llene todos los campos', Colors.red);
    }
    try {
      bool isLogin = await _authProvider.login(email, password);
      if (isLogin) {
        // print('Logueado');
        if (_typeUser == 'client') {
          Client client =
              await _clientProvider.getById(_authProvider.getUser().uid);
          if (client != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'client/map', (route) => false);
            print('Client: $client');
          } else {
            utils.Snackbar.showSnackbar(
                context, key, 'El usuario no es válido ', Colors.red);
            await _authProvider.signOut();
          }
        }
        if (_typeUser == 'admin') {
          Admin admin =
              await _adminProvider.getById(_authProvider.getUser().uid);
          if (admin != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'admin/map', (route) => false);
            print('Client: $Admin');
          } else {
            utils.Snackbar.showSnackbar(
                context, key, 'El usuario no es válido ', Colors.red);
            await _authProvider.signOut();
          }
        }
      }
    } catch (error) {
      utils.Snackbar.showSnackbar(context, key,
          'Comuniquese con el administrador. Error: $error', Colors.red);
      print('ERROR $error ');
      if (isLogin == false) {
        // print('No logueado');
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
