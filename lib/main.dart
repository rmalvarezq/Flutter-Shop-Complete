import 'package:flutter/material.dart';
import 'package:shopflutter/src/bloc/provider.dart';
import 'package:shopflutter/src/pages/home_page.dart';
import 'package:shopflutter/src/pages/login_page.dart';
import 'package:shopflutter/src/pages/producto_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        // home: HomePage(),
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'login': (_) => LoginPage(),
          'producto': (_) => ProductoPage(),
        },
      ),
    );
  }
}
