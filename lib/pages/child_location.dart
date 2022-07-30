import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class ChildLocation extends StatefulWidget {
  const ChildLocation({Key? key}) : super(key: key);

  @override
  _ChildLocationState createState() => _ChildLocationState();
}

class _ChildLocationState extends State<ChildLocation> {
  final Completer<GoogleMapController> _controller = Completer();// return object map
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(38.9637, 35.2433),
      zoom:18.0,);
  List<Marker> Markers =[
    const Marker(
      markerId: MarkerId('place 1'),
      infoWindow: InfoWindow(title: 'so nice place'),
      position: LatLng(41.0175302,29.1413539),
    ),
    const Marker(
      markerId: MarkerId('place 2'),
      infoWindow: InfoWindow(title: 'this place is so nice'),
      position: LatLng(41.0154117,29.1190112)
     ),
    const Marker(
      markerId: MarkerId('place 3'),
      infoWindow: InfoWindow(title: 'this place is so nice'),
       position: LatLng(41.0240567,29.0840848)
     ),
  ];
  storeChildLocation(){
    Location location = Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
      debugPrint(currentLocation.latitude.toString() + "  " + currentLocation.longitude.toString());
    });

  }
  @override
  void initState() {
    super.initState();
    //debugPrint("--------------");
    //storeChildLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Location'),
        backgroundColor: Colors.green[700],
      ),
      body:  GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Markers.toSet(),
      ),
    );
  }
}
