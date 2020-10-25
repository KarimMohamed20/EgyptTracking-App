import 'dart:async';

import 'package:app/Components/Driver/Ride/start.dart';
import 'package:app/Controller/Driver/Ride/connect.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:app/Controller/Driver/Ride/start.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverCurrentRide extends StatefulWidget {
  @override
  _DriverCurrentRideState createState() => _DriverCurrentRideState();
}

class _DriverCurrentRideState extends State<DriverCurrentRide> {
  // Socket
  IO.Socket currentSocket;

  // Variables
  DriverGetRides ride = Get.find();
  Set<Marker> markers = {};
  GoogleMapController googleMapController;

  StreamSubscription<Position> currentLocationStream;
  Position currentLocationPosition = Position(latitude: 0.0, longitude: 0.0);

  listenAndSendLocation() {
    currentLocationStream = getPositionStream(
            desiredAccuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 5))
        .listen((Position position) async {
      if (currentLocationPosition.latitude == position.latitude) {
      } else {
        await googleMapController.moveCamera(CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude)));
        markers.removeWhere((marker)=> marker.markerId.value == 'myLocation');
        markers.add(Marker(markerId: MarkerId('myLocation'),
        position: LatLng(position.latitude,position.longitude)));
        currentSocket.emit('location',
            '{"lat":${position.latitude}, "lng":${position.longitude}}');
        currentLocationPosition = position;
        setState(() {});
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    addStudentsToMap();
    connectToSocket();
    listenAndSendLocation();
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
    currentLocationStream?.cancel();
    currentSocket.close();
    currentSocket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('/driver/ride/students');
            },
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Students",
                style: TextStyle(color: Colors.white),
              ),
            )),
          )
        ],
        title: Text(ride.currentRide.value.rideName),
      ),
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              
                initialCameraPosition: CameraPosition(
                  target: LatLng(0.0, 0.0),
                ),
                markers: markers,
                myLocationEnabled: true,
                onMapCreated: onMapCreated),
            StartRideComponents().startOrEnd('End Ride', () {
              StartRideController().startRide(false);
            })
          ],
        ),
      ),
    );
  }

  void connectToSocket() {
    currentSocket = DriverConnectRide().connect();
    setState(() {});
  }

  addStudentsToMap() {
    if (ride.currentRide.value.students.isNotEmpty) {
      markers.addAll(ride.currentRide.value.studentsObjects.map((e) => Marker(
          markerId: MarkerId(e['id']),
          infoWindow: InfoWindow(title: 'Student', snippet: e['fullName']),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
          position: LatLng(double.parse(e['lat']), double.parse(e['lng'])))));
    }
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
    markers.add(Marker(
      markerId: MarkerId('myLocation'),
      position: LatLng(position.latitude, position.longitude),
    ));

    setState(() {});
  }
}
