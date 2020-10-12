import 'package:app/Controller/Driver/Ride/connect.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  void initState() {
    super.initState();
    DriverConnectRide().connect('5f826bc6baea48cd7ffa8e71', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNWY4MjRhNjVhOWIzYTliNmVmZDdmYTNmIn0sImlhdCI6MTYwMjQ4MDQ2NCwiZXhwIjoxNjM0MDE2NDY0fQ.EHwV234ZNNPFR5JkwPCjthworaSBVLV2m09wsOGvPyo');
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(child: Text("Home!"),),
    );
  }
}