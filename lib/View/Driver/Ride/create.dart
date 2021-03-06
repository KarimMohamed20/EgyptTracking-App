import 'package:app/Components/Driver/Ride/create.dart';
import 'package:flutter/material.dart';

class CreateDriverRide extends StatefulWidget {
  @override
  _CreateDriverRideState createState() => _CreateDriverRideState();
}

class _CreateDriverRideState extends State<CreateDriverRide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Ride"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RideCreateComponents().logo(),
            RideCreateComponents().createForm(),
            RideCreateComponents().submitButton(),
          ],
        ),
      ),
    );
  }
}
