import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapsDemo extends StatefulWidget {
  MapsDemo() : super();

  final String title = "Product Finder";

  @override
  MapsDemoState createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  //
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(-17.827,  31.01194);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(-17.827, 31.01194),
    tilt: 59.440,
    zoom: 11.0,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.indigo,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.indigo,
          ),
          body:ListView(
            children: [
              Container(
                height: 350,
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                      mapType: _currentMapType,
                      markers: _markers,
                      onCameraMove: _onCameraMove,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: <Widget>[
                            button(_onMapTypeButtonPressed, Icons.map),
                            SizedBox(
                              height: 16.0,
                            ),
                            button(_onAddMarkerButtonPressed, Icons.add_location),
                            SizedBox(
                              height: 16.0,
                            ),
                            button(_goToPosition1, Icons.location_searching),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top:18.0, left: 10),
                  child: Text("Contacts Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ),
              Divider(color: Colors.indigo,thickness: 4,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text("Address:", style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),),
                        Text("Harare Institute of Technology, Harare")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text("Cell Number:", style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),),
                        Text("+263 774 539 645")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text("WhatsApp Number:", style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),),
                        Text("+263 774 539 645")
                      ],
                    ),
                  ),
                  Divider(color: Colors.indigo,thickness: 4,),



                ],
              )
            ],
          )
      ),
    );
  }
}