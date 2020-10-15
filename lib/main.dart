import 'package:app/Controller/Driver/Home/home.dart';
import 'package:app/Controller/Student/Home/home.dart';
import 'package:app/Models/User/userController.dart';
import 'package:app/View/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/Auth/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    userController.addData();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: _getInitialRoute(),
      routes: {
        "/": (context) => LoginPage(),
        "/student/home": (context) => StudentHome(),
        "/student/driver": (context) => DriverHome(),
      },
    );
  }

  String _getInitialRoute() {
    if (userController.user.value.token != null) {
      if (userController.user.value.accountType == "Driver") {
        return '/driver/home';
      } else if (userController.user.value.accountType == "Student") {
        return '/student/home';
      }
    }
    return '/';
  }
}
