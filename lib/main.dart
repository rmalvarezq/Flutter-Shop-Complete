import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopflutter/login/admin/register/admin_register_page.dart';
import 'package:shopflutter/login/client/registro/client_register_page.dart';
import 'package:shopflutter/login/home/home_login_page.dart';
import 'package:shopflutter/login/pages/login_page.dart';
// import 'package:shopflutter/login/home/home_login_page.dart';
import 'package:shopflutter/src/bloc/provider.dart';
import 'package:shopflutter/src/pages/login_page.dart';
// import 'package:shopflutter/src/pages/login_page.dart';
// import 'package:shopflutter/src/pages/home_page.dart';
// import 'package:shopflutter/src/pages/login_page.dart';
import 'package:shopflutter/src/pages/producto_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => print('Inicializado'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Material App',
        // home: HomePage(),
        // initialRoute: 'home',
        // home: ,
        home: HomeLoginPage(),
        routes: {
          // 'home': (_) => HomePage(),
          // 'login': (_) => LoginPage(),
          'home': (_) => HomeLoginPage(),
          'producto': (_) => ProductoPage(),
          'login': (_) => LoginPage(),
          'login/private': (_) => LoginPrivatePage(),
          'admin/register': (_) => AdminRegisterPage(),
          'client/register': (_) => ClientRegisterPage(),
        },
      ),
    );
  }
}
