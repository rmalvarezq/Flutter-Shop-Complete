import 'dart:convert';
import 'dart:io';
// import 'dart:html';

// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
import 'package:shopflutter/src/models/producto_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class ProductosProvider {
  final String _url = 'https://mapa-flutter-7df2a-default-rtdb.firebaseio.com';
  firebase_storage.Reference ref;
  Future<bool> crearProducto(ProductoModel producto) async {
    final url = Uri.parse('$_url/productos.json');
    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = Uri.parse('$_url/productos/${producto.id}.json');
    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = Uri.parse('$_url/productos.json');
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = [];
    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });
    // print(decodedData);
    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = Uri.parse('$_url/productos/$id.json');
    await http.delete(url);
    // final resp = await http.delete(url);
    // print(json.decode(resp.body));
    // print(resp.body);
    return 1;
  }

  Future uploadFile(File img, CollectionReference imgRef) async {
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(img.path)}');
    await ref.putFile(img).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        imgRef.add({'url': value});
      });
    });
  }

  Future uploadImageToFirebase(BuildContext context, File _imageFile) async {
    String fileName = Path.basename(_imageFile.path);
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('uploads/$fileName');
    firebase_storage.UploadTask uploadTask = ref.putFile(_imageFile);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => print('realizado'));
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  Future getImage()async{
    firebase_storage.Reference ref;
    ref.getDownloadURL();
    
  }
}
