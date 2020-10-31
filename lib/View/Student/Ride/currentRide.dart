import 'dart:convert';
import 'package:app/Controller/Student/Ride/connect.dart';
import 'package:app/Controller/Student/Ride/get.dart';
import 'package:app/Models/User/userController.dart';
import 'package:flutter/material.dart';
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
    print(user.user.value.currentRideId);
    currentSocket.on(user.user.value.currentRideId, (data) async {
      var coordinates = jsonDecode(data);
      if (coordinates['type'] == 'end') {
        Get.defaultDialog(
            title: 'Your driver ended the ride',
            middleText: 'You supposed to be at your destination in few minutes',
            barrierDismissible: false,
            confirm: FlatButton(
                onPressed: () {
                  Get.toNamed("/student/home");
                  dispose();
                },
                child: Text('Go back')));
      } else {
        await googleMapController.moveCamera(CameraUpdate.newLatLng(
            LatLng(coordinates['lat'], coordinates['lng'])));

        markers = {
          Marker(
              infoWindow: InfoWindow(
                snippet: ride.ride.value.driver.fullName,
              ),
              markerId: MarkerId('driver'),
              position: LatLng(coordinates['lat'], coordinates['lng']))
        };
        setState(() {});
      }
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
        title: Text('Ride'),
      ),
      body: Container(
        child: Obx(
          () {
            return ride.loading.value == 'loading'
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ride.statusCode.value != 200
                    ? Center(
                        child: Text("Your ride didn't started yet"),
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
    // Set controller
    googleMapController = controller;
    setState(() {});

    // Move Camera to current location
    await controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(ride.ride.value.lastLat, ride.ride.value.lastLng), 14));
    // Set Marker on current location
    markers.add(Marker(
      infoWindow: InfoWindow(
        title: ride.ride.value.driver.fullName
      ),
      markerId: MarkerId('driver'),
      position: LatLng(ride.ride.value.lastLat, ride.ride.value.lastLng),
    ));
    setState(() {});

    // Listen to location changes
    listenAndSendLocation();
  }
}
