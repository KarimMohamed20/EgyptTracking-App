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

  // Change Marker Location when camera moves
  onCameraMove(CameraPosition position) {
    markers = {
      Marker(
        markerId: MarkerId('myLocation'),
        position: position.target,
      )
    };
    setState(() {});
    _registerController.currentLocation.value = position.target;
    _registerController.currentLocation.refresh();
  }

  // Update Map Location to Current User Location
  onMapCreated(GoogleMapController controller) async {
    // Get current location
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // Set controller
    googleMapController = controller;
    setState(() {});

    // Move Camera to current location
    controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude), 14));

    // Set Marker on current location
    markers = {
      Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(position.latitude, position.longitude),
      )
    };
    setState(() {});
    // Update register value
    _registerController.currentLocation.value =
        LatLng(position.latitude, position.longitude);
    _registerController.currentLocation.refresh();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
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
              onMapCreated: onMapCreated,
            )
          ],
        ),
      ),
    );
  }
}
