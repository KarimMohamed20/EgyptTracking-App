import 'dart:convert';
import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Models/User/userController.dart';
import 'package:app/View/Driver/Home/home.dart';
import 'package:app/View/Student/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  APIServices controller = APIServices();
  UserController user = Get.find();
  TextEditingController fullNameTextController;
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  TextEditingController confirmPasswordTextController;
  var currentLocation = LatLng(0.0, 0.0).obs;

  @override
  void onInit() {
    fullNameTextController = TextEditingController();
    emailTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    fullNameTextController?.dispose();
    emailTextController?.dispose();
    passwordTextController?.dispose();
    confirmPasswordTextController?.dispose();
    super.onClose();
  }

  register() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    if (confirmPasswordTextController.value.text ==
        passwordTextController.value.text) {
      Response res = await controller.post(APIConfig.register, body: {
        "fullName": fullNameTextController.text,
        "email": emailTextController.text,
        "password": passwordTextController.text,
        "lat": currentLocation.value.latitude.toString(),
        "lng": currentLocation.value.longitude.toString(),
        "accountType": "Student"
      }).catchError((e) {
        Get.back();
      });
      _handleResponse(res);
    } else {
       Get.back();
      Get.showSnackbar(GetBar(
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        title: 'Please confirm your password',
        message: 'Please match your password with confirm password',
      ));
    }
  }

  _handleResponse(Response res) async {
    // Invalid User Credentials
    if (res.statusCode == 400) {
     Get.back();
      Get.showSnackbar(GetBar(
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        title: 'Enter a correct email',
        message: 'Please enter a correct email and password',
      ));
    }
    // Internal Server Error
    if (res.statusCode == 500) {
     Get.back();
      Get.showSnackbar(GetBar(
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        title: 'Currently there is an error',
        message: 'Please try again later..',
      ));
    }

    // Successful Login
    if (res.statusCode == 200) {
      user.user.value.user = jsonDecode(res.body)['user'];
      user.user.value.token = jsonDecode(res.body)['token'];
      var prefs = await SharedPreferences.getInstance();

      user.user.refresh();
      // Save credentials
      await prefs.setString('user', jsonEncode(user.user.value.user));
      await prefs.setString('token', jsonEncode(user.user.value.token));

      // Navigate to home
      if (user.user.value.accountType == 'Student') {
        Get.offAll(StudentHome());
      } else if (user.user.value.accountType == "Driver") {
        Get.offAll(DriverHome());
      }
    }
  }
}
