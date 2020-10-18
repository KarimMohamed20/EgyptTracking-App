import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverCreateRideController extends GetxController {
  DriverGetRides _driverGetRides = Get.find();
  APIServices _apiController = APIServices();
  TextEditingController rideName;
  TextEditingController helperName;
  RxBool started = false.obs;

  @override
  void onInit() {
    rideName = TextEditingController();
    helperName = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    rideName?.dispose();
    helperName?.dispose();
    super.onClose();
  }

  createRide() async {
    if (rideName.text.length < 2 || helperName.text.length < 2) {
      Get.showSnackbar(GetBar(
        duration: Duration(seconds: 3),
        title: 'Please enter more than 2 characters in names.',
        message:
            "If you have any trouble with creating ride please contact us.",
      ));
    } else {
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      await _apiController.post(APIConfig.createRide, body: {
        "rideName": rideName.text,
        "helperName": helperName.text,
        "started": started
      }).catchError((e) {
        Get.back();
      });
      Get.back();
      Get.back();
      _driverGetRides.getMyRides();
    }
  }
}
