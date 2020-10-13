import 'package:app/View/Auth/login.dart';
import 'package:flutter/material.dart';
import 'View/Auth/login.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {"/": (context) => LoginPage()},
    );
  }
}
