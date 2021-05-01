// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart';
import 'package:shopflutter/login/admin/register/admin_register_controller.dart';
import 'package:shopflutter/login/utils/otp_widget.dart';
import 'package:shopflutter/login/widgets_login/button_widget.dart';

class AdminRegisterPage extends StatefulWidget {
  @override
  _AdminRegisterPageState createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  AdminRegisterController _registerController = new AdminRegisterController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _registerController.init(context);
      // Firebase.initializeApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _registerController.key,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bannerApp(context),
            SizedBox(
              height: 20,
            ),
            _textRegistro(),
            _textLicensePlate(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 05),
              child: OTPFields(
                pin1: _registerController.pin1Controller,
                pin2: _registerController.pin2Controller,
                pin3: _registerController.pin3Controller,
                pin4: _registerController.pin4Controller,
                pin5: _registerController.pin5Controller,
                pin6: _registerController.pin6Controller,
                pin7: _registerController.pin7Controller,
              ),
            ),
            _crearInputNombre(),
            _textFieldEmail(),
            _textFielPassword(),
            _textFielConfirmPassword(),
            SizedBox(
              height: 30,
            ),
            // _buttonLogin(),
            ButtonLogin(
              onPressed: () {
                _registerController.register();
              },
              text: 'Registrar',
              color: Colors.red,
              icon: Icon(Icons.arrow_forward_ios),
            ),
            _textRegresar(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget _bannerApp(BuildContext context) {
    final double _height_size = MediaQuery.of(context).size.height;
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: Colors.white,
        height: _height_size * 0.3,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset('assets/json/register.json', width: 150, height: 150),
            Text(
              'Fácil y Rápido ',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20,
                  decoration: TextDecoration.underline),
            )
          ],
        ),
      ),
    );
  }

  Widget _textRegistro() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Registro Administrador',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: _registerController.emailController,
        decoration: InputDecoration(
          hintText: 'ejemplo@gmail.com',
          labelText: 'Correo electrónico',
          suffixIcon: Icon(
            Icons.email_outlined,
          ),
        ),
      ),
    );
  }

  Widget _textFielPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _registerController.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Contraseña',
          suffixIcon: Icon(
            Icons.lock_open_outlined,
          ),
        ),
      ),
    );
  }

  Widget _textFielConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _registerController.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Confirmar contraseña',
          suffixIcon: Icon(
            Icons.lock_open_outlined,
          ),
        ),
      ),
    );
  }

  Widget _textRegresar() {
    return GestureDetector(
      onTap: () {
        _registerController.goToLoginPage();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          'Ya tengo cuenta!',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _crearInputNombre() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _registerController.userNameController,
        // autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Nombre de la persona',
          labelText: 'Nombre',
          // helperText: 'ingrese el nombre',
          suffixIcon: Icon(Icons.accessibility),
          // icon: Icon(Icons.account_circle),
        ),
      ),
    );
  }

  Widget _textLicensePlate() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Placa del vehículo',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 17,
        ),
      ),
    );
  }
}
