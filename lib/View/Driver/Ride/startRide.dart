import 'package:app/Models/Ride/ride.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverStartRide extends StatefulWidget {
  @override
  _DriverStartRideState createState() => _DriverStartRideState();
}

class _DriverStartRideState extends State<DriverStartRide> {
  RideModel ride = Get.find();
  Set<Marker> markers = {};
  GoogleMapController googleMapController;

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
  }

  @override
  void initState() {
    super.initState();
    if (ride.students.isNotEmpty) {
      markers.addAll(ride.studentsObjects.map((e) => Marker(
          markerId: e['id'],
          infoWindow: InfoWindow(title: 'Student', snippet: e['name']),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
          position: LatLng(double.parse(e['lat']), double.parse(e['lng'])))));
    }
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
        title: Text(ride.rideName),
      ),
      body: Container(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(0.0, 0.0),
          ),
          markers: markers,
          myLocationEnabled: true,
          onMapCreated: (c) {
            setState(() {
              googleMapController = c;
            });
          },
        ),
      ),
    );
  }
}
