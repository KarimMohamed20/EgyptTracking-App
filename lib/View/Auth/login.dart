import 'package:app/Components/Auth/loginComponents.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          child: Column(
            children: <Widget>[
              LoginComponents().headerLogo(),
              LoginComponents().loginType(),
              LoginComponents().loginFields(),
              LoginComponents().loginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
