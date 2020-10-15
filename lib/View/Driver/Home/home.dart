import 'package:app/Components/Driver/drawer.dart';
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
  UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Obx(()=> Text(_userController.user.value.user == null ? '' : _userController.user.value.fullName)),),
        drawer: DriverDrawer(),
        body: Container(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(_userController.user.value.user == null ? '' : _userController.user.value.email)),
            ],
          ),
        ),
      ),
    );
  }
}
