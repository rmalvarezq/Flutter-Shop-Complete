import 'package:flutter/material.dart';

class Snackbar {
  static void showSnackbar(BuildContext context, GlobalKey<ScaffoldState> key,
      String text, Color color) {
    if (context == null) return;
    if (key == null) return;
    if (key.currentState == null) return;
    FocusScope.of(context).requestFocus(new FocusNode());
    if (key.currentState != null) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
    if (key.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () {},
        // ),
      ));
    }
  }
}
