import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    LatLng latLng = new LatLng(20.689742, -103.3928097);

    final CameraPosition puntoInicial =
        CameraPosition(target: latLng, zoom: 17.5, tilt: 50);

    //Marcadores
    Set<Marker> markers = Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('marker-position'),
      position: latLng,
      infoWindow: InfoWindow(
          title: 'Trabajo', snippet: 'Usted debería estar en este lugar'),
    ));

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              mapType: mapType,
              markers: markers,
              initialCameraPosition: puntoInicial,
              compassEnabled: false,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Container(
            height: 100,
            child: AppBar(
              actions: [
                IconButton(
                  icon: Image.asset('assets/img/logo_mapa.png'),
                  iconSize: 52.0,
                  onPressed: () {},
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
              /*leading: Builder(
                builder: (context) => // Ensure Scaffold is in context
                    IconButton(
                      icon: Image.asset('assets/img/btn_menu.png'),
                      iconSize: 52.0,
                      onPressed: () {},
                    ),
              ),*/
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              FloatingActionButton(
                  child: Icon(Icons.layers),
                  mini: true,
                  elevation: 8,
                  onPressed: () {
                    if (mapType == MapType.normal) {
                      mapType = MapType.satellite;
                    } else {
                      mapType = MapType.normal;
                    }
                    setState(() {});
                  }),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 134, right: 10),
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              FloatingActionButton(
                  child: Icon(Icons.location_searching),
                  elevation: 8,
                  mini: true,
                  onPressed: () async {
                    final GoogleMapController controller =
                        await _controller.future;
                    controller.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: latLng, zoom: 17.5, tilt: 50)));
                  }),
            ]),
          ),
        ],
      ),
    );
  }
}
