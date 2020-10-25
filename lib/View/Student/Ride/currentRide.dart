import 'dart:convert';

import 'package:app/Controller/Student/Ride/connect.dart';
import 'package:app/Controller/Student/Ride/get.dart';
import 'package:app/Models/User/userController.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class StudentCurrentRide extends StatefulWidget {
  @override
  _StudentCurrentRideState createState() => _StudentCurrentRideState();
}

class _StudentCurrentRideState extends State<StudentCurrentRide> {
  // Socket
  IO.Socket currentSocket;

  // Variables
  StudentGetRides ride = Get.put(StudentGetRides());
  UserController user = Get.find();

  Set<Marker> markers = {};
  GoogleMapController googleMapController;

  listenAndSendLocation() {
    currentSocket.on(user.user.value.currentRideId, (data) async {
      var coordinates = jsonDecode(data);

      await googleMapController.moveCamera(CameraUpdate.newLatLng(
          LatLng(coordinates['lat'], coordinates['lng'])));

      markers = {
        Marker(
            markerId: MarkerId('driver'),
            position: LatLng(coordinates['lat'], coordinates['lng']))
      };
      setState(() {});
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    connectToSocket();
    ride.getRide();
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController?.dispose();
    currentSocket?.close();
    currentSocket?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('/Student/ride/students');
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
        title: Text('Ride'),
      ),
      body: Container(
        child: Obx(
          () {
            return ride.loading.value == 'loading'
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(0.0, 0.0),
                          ),
                          markers: markers,
                          myLocationEnabled: true,
                          onMapCreated: onMapCreated),
                    ],
                  );
          },
        ),
      ),
    );
  }

  void connectToSocket() {
    currentSocket = StudentConnectRide().connect();
    setState(() {});
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
    await controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude), 14));
    // Set Marker on current location
    markers.add(Marker(
      markerId: MarkerId('driver'),
      position: LatLng(position.latitude, position.longitude),
    ));
    setState(() {});

    // Listen to location changes
    listenAndSendLocation();
  }
}