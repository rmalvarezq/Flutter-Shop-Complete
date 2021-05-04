import 'package:flutter/material.dart';
import 'package:shopflutter/login/models/admin.dart';
import 'package:shopflutter/login/providers/admin_provider.dart';
import 'package:shopflutter/login/providers/auth_provider.dart';
import 'package:shopflutter/login/utils/my_progress_dialog.dart';
import 'package:shopflutter/login/utils/snackbar.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';

class AdminRegisterController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  TextEditingController pin1Controller = new TextEditingController();
  TextEditingController pin2Controller = new TextEditingController();
  TextEditingController pin3Controller = new TextEditingController();
  TextEditingController pin4Controller = new TextEditingController();
  TextEditingController pin5Controller = new TextEditingController();
  TextEditingController pin6Controller = new TextEditingController();
  TextEditingController pin7Controller = new TextEditingController();

  AuthProvider _authProvider;
  AdminProvider _adminProvider;
  ProgressDialog _progressDialog;

  void init(BuildContext context) {
    this.context = context;
    _authProvider = new AuthProvider();
    _adminProvider = new AdminProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'espere un momento');
  }

  Future register() async {
    String userName = userNameController.text;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    bool isRegister = true;

    String pin1 = pin1Controller.text.trim();
    String pin2 = pin2Controller.text.trim();
    String pin3 = pin3Controller.text.trim();
    String pin4 = pin4Controller.text.trim();
    String pin5 = pin5Controller.text.trim();
    String pin6 = pin6Controller.text.trim();
    String pin7 = pin7Controller.text.trim();

    String plate = '$pin1$pin2$pin3-$pin4$pin5$pin6$pin7';

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
    try {
      isRegister = await _authProvider.register(email, password);
      await _authProvider.register(email, password);
      Admin admin = new Admin(
        id: _authProvider.getUser().uid,
        email: _authProvider.getUser().email,
        username: userName,
        password: password,
        plate: plate,
      );
      print('nombre: $userName Contraseña: $password');

      await _adminProvider.create(admin);
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(
          context, key, 'Registro exitoso', Colors.green);
      if (isRegister) {
        Navigator.pushNamedAndRemoveUntil(
            context, 'admin/map', (route) => false);
      }
    } catch (error) {
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key,
          'Comuniquese con el administrador. Error: $error', Colors.red);
      print('ERROR $error ');
    }
  }

  void goToLoginPage() {
    Navigator.pushNamed(context, 'login');
  }
}
