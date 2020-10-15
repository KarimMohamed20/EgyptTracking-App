import 'package:app/Controller/Auth/login.dart';
import 'package:app/Models/User/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DriverHome extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DriverHome> {
  UserController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Text(_loginController.user.value.email)),
            RaisedButton(
              onPressed: () {
                _loginController.user.value.user = {
                  "email": "spam@dplyr.dev"
                };
                _loginController.user.refresh();
                print(_loginController.user.value.email);
              },
              child: Text("Update Email"),
            )
          ],
        ),
      ),
    );
  }
}
