import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart';
import 'package:shopflutter/login/pages/login_controller.dart';
import 'package:shopflutter/login/widgets_login/button_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _loginController = new LoginController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _loginController.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _loginController.key,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bannerApp(context),
            SizedBox(
              height: 20,
            ),
            _textDescription('Continúa con tu:'),
            _textLogin(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            _textFieldEmail(),
            _textFielPassword(),
            SizedBox(
              height: 30,
            ),
            // _buttonLogin(),
            ButtonLogin(
              onPressed: () {
                _loginController.login();
              },
              text: 'Iniciar sesión',
              color: Colors.red,
              icon: Icon(Icons.arrow_forward_ios),
            ),
            _textRegistrarse(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget _bannerApp(BuildContext context) {
    final height_size = MediaQuery.of(context).size.height;

    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: Colors.white,
        height: height_size * 0.3,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset('assets/json/an-electric-car.json',
                width: 150, height: 150),
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

  Widget _textLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Login',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
      ),
    );
  }

  Widget _textDescription(String text) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        (text),
        style: TextStyle(
            color: Colors.black45, fontSize: 24, fontFamily: 'NimbusSans'),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: _loginController.emailController,
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
        controller: _loginController.passwordController,
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

  Widget _textRegistrarse() {
    return GestureDetector(
      onTap: () {
        _loginController.goToRegisterPage();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          'Regístrate!',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ),
    );
  }
}
