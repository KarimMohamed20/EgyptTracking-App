import 'package:app/Components/Driver/Ride/rideTile.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:app/Models/Ride/ride.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverRides extends StatefulWidget {
  @override
  _DriverRidesState createState() => _DriverRidesState();
}

class _DriverRidesState extends State<DriverRides> {
  DriverGetRides _getRides = Get.put(DriverGetRides());

  @override
  void initState() {
    super.initState();

    _getRides.getMyRides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('/driver/rides/create');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Icon(Icons.add)),
            ),
          )
        ],
        title: Text("Rides"),
      ),
      body: Obx(() {
        if (_getRides.status.value == 'loading') {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (_getRides.status.value == 'empty') {
          return Center(
            child: Text('Currently you don\'t have rides.'),
          );
        } else {
          return ListView.builder(
              itemCount: _getRides.rides.length,
              itemBuilder: (context, i) {
                RideModel ride = RideModel(ride: _getRides.rides.value[i]);
                return RideTile(
                  helperName: ride.helperName,
                  live: ride.started,
                  rideId: ride.id,
                  rideName: ride.rideName,
                );
              });
        }
      }),
    );
  }
}
