import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shopflutter/src/models/producto_model.dart';
import 'package:shopflutter/src/providers/productos_provider.dart';
import 'package:shopflutter/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductosProvider productosProvider = new ProductosProvider();
  ProductoModel producto = new ProductoModel();
  CollectionReference imgRef;
  bool _guardando = false;
  File foto;
  @override
  void initState() {
    Firebase.initializeApp();
    imgRef = FirebaseFirestore.instance.collection('imgURLS');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                SizedBox(
                  height: 20,
                ),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'precio',
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Sólo Números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            // side: BorderSide(color: Colors.red),
          ),
        ),
      ),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  void _submit() {
    // Cuando el fomulario es  válido
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });
    if (producto.id == null) {
      productosProvider.crearProducto(producto);
      productosProvider
          .uploadFile(foto, imgRef)
          .then((value) => print('IMAGEN INSERTADA CORRECTAMENTE'));
    } else {
      productosProvider.editarProducto(producto);
    }
    setState(() {
      _guardando = false;
    });
    mostrarSnackBar('Registro guardado');
    Navigator.pushNamed(context, 'home');
  }

  void mostrarSnackBar(String mensaje) {
    if (scaffoldKey == null) return;
    if (scaffoldKey.currentState == null) return;
    FocusScope.of(context).requestFocus(new FocusNode());
    if (scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
    if (scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: Text(
          mensaje,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ));
    }
  }

  _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return Container();
    } else {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final _picker = ImagePicker();
    final pickerFile = await _picker.getImage(source: origen);
    foto = File(pickerFile.path);
    if (foto != null) {
      producto.fotoUrl = null;
    }
    setState(() {});
  }
}
