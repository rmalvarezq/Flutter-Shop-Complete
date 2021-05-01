// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart';
import 'package:shopflutter/login/client/registro/client_register_controller.dart';
import 'package:shopflutter/login/widgets_login/button_widget.dart';

class ClientRegisterPage extends StatefulWidget {
  @override
  _ClientRegisterPageState createState() => _ClientRegisterPageState();
}

class _ClientRegisterPageState extends State<ClientRegisterPage> {
  ClientRegisterController _registerController = new ClientRegisterController();
  @override
  void initState() {
    // Firebase.initializeApp();
      super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _registerController.init(context);
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
              text: 'Registrarse',
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
    double _height_size = MediaQuery.of(context).size.height;
    double _width_size = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: Colors.white,
        height: _height_size * 0.3,
        width: _width_size,
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
        'Registro',
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
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: 'Nombre de la persona',
          labelText: 'Nombre',
          suffixIcon: Icon(Icons.accessibility),
        ),
      ),
    );
  }
}
