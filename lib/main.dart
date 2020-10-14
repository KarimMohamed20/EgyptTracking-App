import 'package:app/View/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'View/Auth/login.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      routes: {"/": (context) => LoginPage()},
    );
  }
}
