import 'package:app/Controller/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  RegisterController _registerController = Get.find();

  Set markers = {};
  GoogleMapController googleMapController;

  onCameraMove(CameraPosition position) {
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 114, 194, 1),
        title: Text("My Location"),
      ),
      body: Container(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(23.8859, 45.0792)),
              markers: markers,

              onCameraMove: onCameraMove,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                googleMapController = controller;
              },
            )
          ],
        ),
      ),
    );
  }
}
