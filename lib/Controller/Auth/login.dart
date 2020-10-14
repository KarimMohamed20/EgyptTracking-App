import 'dart:convert';

import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Controller/Student/Home/home.dart';
import 'package:app/Models/Student/user.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class LoginController extends GetxController {
  APIServices controller = APIServices();
  Rx<StudentModel> student = StudentModel().obs;
  TextEditingController emailTextController;
  TextEditingController passwordTextController;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
    super.onClose();
  }

  login() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    Response res = await controller.post(APIConfig.login, body: {
      "email": emailTextController.text,
      "password": passwordTextController.text
    }).catchError((e) {
      Get.back();
    });

    if (res.statusCode == 400) {
      Get.back();
      Get.showSnackbar(GetBar(
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        title: 'Invalid Email or Password',
        message: 'Please enter a correct email and password',
      ));
    }
    if (res.statusCode == 500) {
      Get.back();
      Get.showSnackbar(GetBar(
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        title: 'Currently there is an error',
        message: 'Please try again later..',
      ));
    }
    if (res.statusCode == 200) {
      student.value.user = jsonDecode(res.body)['user'];
     // update(['students']);
      Get.off(StudentHome());
    }
  }
}
