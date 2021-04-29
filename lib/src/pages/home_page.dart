import 'package:flutter/material.dart';
import 'package:shopflutter/src/models/producto_model.dart';
import 'package:shopflutter/src/providers/productos_provider.dart';
// import 'package:shopflutter/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  final productosProvider = new ProductosProvider();
  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _crearListado(context),
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

  Widget _crearListado(BuildContext context) {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        final productos = snapshot.data;
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) =>
                _crearItem(context, productos[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto,
     ) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.pinkAccent,
      ),
      onDismissed: (direction) {
        productosProvider.borrarProducto(producto.id);
        // productosProvider.borrarProducto(producto.id).then(
        //       (value) => setState(() {
        //         prod.removeAt(i);
        //       }),
        //     );
      },
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text(producto.id),
        onTap: () => Navigator.pushNamed(context, 'producto',arguments: producto),
      ),
    );
  }
}
