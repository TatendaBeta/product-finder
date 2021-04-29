import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class LocationDetail extends StatefulWidget {
  @override
  _LocationDetailState createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetail> {
  String latitudeData = "";
  String longitudeData ="";

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  getCurrentLocation() async{
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    setState(() {
      latitudeData = '${geoposition.latitude}';
      longitudeData = '${geoposition.longitude}';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.indigo,
        title: Text("Location"),
      ),

      body: Container(
        child: Column(
          children: [
            Text(latitudeData),
            Text(longitudeData),

          ],
        ),
      ),


    );
  }
}
