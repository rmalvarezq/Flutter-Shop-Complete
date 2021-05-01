import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonLogin extends StatelessWidget {
  final color;
  final text;
  final textColor;
  final icon;
  final Function onPressed;

  ButtonLogin(
      {this.color = Colors.red,
      @required this.text,
      this.textColor = Colors.white,
      this.icon = Icons.arrow_forward_ios,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
            onPrimary: Colors.white,
            onSurface: color,
            elevation: 5.0,
            padding: EdgeInsets.all(10),
            shadowColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          ),
          onPressed: () {
            // Navigator.pushNamed(context, 'loading');
            onPressed();
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(text,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    height: 50,
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      radius: 15,
                      child: icon,
                      foregroundColor: color,
                      backgroundColor: Colors.white,
                    )),
              ),
            ],
          )),
    );
  }
}
