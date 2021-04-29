import 'package:flutter/material.dart';
import 'package:shopflutter/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Container(
        child: Column(),
      ),
      floatingActionButton: _crearBoton(context, 'producto', Icon(Icons.add)),
    );
  }

  Widget _crearBoton(BuildContext context, String url, Icon icon) {
    return FloatingActionButton(
      child: icon,
      onPressed: () => Navigator.pushNamed(context, url),
      backgroundColor: Colors.deepPurple,
    );
  }
}
