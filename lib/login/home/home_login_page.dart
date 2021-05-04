import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart';
import 'package:shopflutter/login/home/home_controller.dart';
import 'package:shopflutter/login/pages/login_controller.dart';

class HomeLoginPage extends StatefulWidget {
  @override
  _HomeLoginPageState createState() => _HomeLoginPageState();
}

class _HomeLoginPageState extends State<HomeLoginPage> {
   LoginController _loginController = new LoginController();
  final _con = new HomeController();
   @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _loginController.init(context);
    _con.init(context); //inicializa el controlador
      // 
    });
  }

  @override
  Widget build(BuildContext context) {
    // final height_size = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0x00000000),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Color(0xFF8C2480),
                Color(0xFFCE587D),
                Colors.blue[300],
                Colors.cyan,
              ])),
          child: Column(
            children: [
              _bannerApp(context),
              SizedBox(
                height: 50,
              ),
              _textTypeTitle('Shop Test '),
              SizedBox(
                height: 30,
              ),
              _imageCircle(context, 'assets/img/driver.png', 'admin'),
              SizedBox(
                height: 10,
              ),
              _textSelectYourRole('Administrador'),
              SizedBox(
                height: 30,
              ),
              _imageCircle(context, 'assets/img/pasajero.png', 'client'),
              SizedBox(
                height: 10,
              ),
              _textSelectYourRole('Usuario'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textTypeTitle(String textUser) {
    return Text(
      textUser,
      style:
          TextStyle(color: Colors.white70, fontSize: 25, fontFamily: 'OneDay'),
    );
  }

  Widget _textSelectYourRole(String textUser) {
    return Text(
      textUser,
      style:
          TextStyle(color: Colors.white70, fontSize: 20, fontFamily: 'OneDay'),
    );
  }

  Widget _imageCircle(BuildContext context, String url, String typeUser) {
    return GestureDetector(
      onTap: () => _con.goToLoginPage(typeUser),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(url),
        radius: 50,
      ),
    );
  }

  Widget _bannerApp(BuildContext context) {
    final height_size = MediaQuery.of(context).size.height;
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: Colors.white,
        height: height_size * 0.25,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset('assets/json/car.json', width: 150, height: 150),
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
}
