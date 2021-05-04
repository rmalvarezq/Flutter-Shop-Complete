import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopflutter/login/admin/map/admin_map_controller.dart';

class AdminMapPage extends StatefulWidget {
  @override
  _AdminMapPageState createState() => _AdminMapPageState();
}

class _AdminMapPageState extends State<AdminMapPage> {
  AdminMapController _con = new AdminMapController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonDrawer(),
                    _buttonCenterPosition(),
                  ],
                ),
                Expanded(child: Container()),
                _buttonConnect(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonCenterPosition() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: CircleBorder(),
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(10),
          
          child: Icon(
            
            Icons.location_searching,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buttonDrawer() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ));
  }

  Widget _buttonConnect() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: ElevatedButton(
        child: Text('Contectarse'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _googleMapsWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.OnMapCreated,
    );
  }
}
