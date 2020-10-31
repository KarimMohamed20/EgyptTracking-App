import 'package:app/Models/User/userController.dart';
import 'package:app/View/Auth/currentLocation.dart';
import 'package:app/View/Auth/login.dart';
import 'package:app/View/Driver/Chat/students.dart';
import 'package:app/View/Driver/Ride/create.dart';
import 'package:app/View/Driver/Ride/currentRide.dart';
import 'package:app/View/Driver/Ride/getStudents.dart';
import 'package:app/View/Driver/Ride/rides.dart';
import 'package:app/View/Driver/Ride/startRide.dart';
import 'package:app/View/Driver/Ride/students.dart';
import 'package:app/View/Student/Chat/chats.dart';
import 'package:app/View/Student/Ride/currentRide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/Auth/login.dart';
import 'View/Auth/register.dart';
import 'View/Driver/Home/home.dart';
import 'View/Student/Home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var userController = Get.put(UserController());
  await userController.addData();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: _getInitialRoute(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/register/location": (context) => CurrentLocation(),
        "/student/home": (context) => StudentHome(),
        "/student/messages": (context) => ChatStudents(),
        "/students": (context) => GetStudents(),
        "/student/ride": (context) => StudentCurrentRide(),
        "/driver/home": (context) => DriverHome(),
        "/driver/rides": (context) => DriverRides(),
        "/driver/rides/create": (context) => CreateDriverRide(),
        "/driver/ride/start": (context) => DriverStartRide(),
        "/driver/ride/students": (context) => RideStudents(),
        "/driver/currentRide": (context) => DriverCurrentRide(),
        '/driver/messages': (context) => GetChatStudents()
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
