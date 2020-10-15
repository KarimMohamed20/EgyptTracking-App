import 'package:app/Controller/Driver/Home/home.dart';
import 'package:app/Controller/Student/Home/home.dart';
import 'package:app/Models/User/userController.dart';
import 'package:app/View/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/Auth/login.dart';

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
      routes: {
        "/": (context) => LoginPage(),
        "/student/home": (context) => StudentHome(),
        "/driver/home": (context) => DriverHome(),
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
