import 'package:flutter/material.dart';
import 'package:shopflutter/login/models/client.dart';
import 'package:shopflutter/login/providers/auth_provider.dart';
import 'package:shopflutter/login/providers/client_provider.dart';
import 'package:shopflutter/login/utils/my_progress_dialog.dart';
import 'package:shopflutter/login/utils/snackbar.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';

class ClientRegisterController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  AuthProvider _authProvider;
  ClientProvider _clientProvider;
  ProgressDialog _progressDialog;

  // variables
  bool isRegister = false;

  void init(BuildContext context) {
    this.context = context;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'espere un momento');
  }

  Future register() async {
    String userName = userNameController.text;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (userName.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) {
      print('Llene todos los campso');
      utils.Snackbar.showSnackbar(
          context, key, 'Llene todos los campos', Colors.red);
      return;
    }
    if (confirmPassword != password) {
      utils.Snackbar.showSnackbar(
          context, key, 'Contraseñas distintas', Colors.red);
      print('Contraseñas distintas');

      return;
    }
    if (password.length < 6) {
      utils.Snackbar.showSnackbar(context, key,
          'El password debe tener al menos 6 caracteres', Colors.red);
      print('El password debe tener al menos 6 caracteres');
      return;
    }
    _progressDialog.show();
    Navigator.pushNamedAndRemoveUntil(context, 'client/map', (route) => false);
    try {
      // isRegister = await _authProvider.register(email, password);
      await _authProvider.register(email, password);
      Client client = new Client(
        id: _authProvider.getUser().uid,
        email: _authProvider.getUser().email,
        username: userName,
        password: password,
      );
      // print('nombre: $userName Contraseña: $password');
      await _clientProvider.create(client);
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(
          context, key, 'Registro exitoso', Colors.green);
    } catch (error) {
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key,
          'Comuniquese con el administrador. Error: $error', Colors.red);
      // print('ERROR $error ');
    }
  }

  void goToLoginPage() {
    Navigator.pushNamed(context, 'login');
  }
}
