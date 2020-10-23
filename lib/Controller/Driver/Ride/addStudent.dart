import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:app/Controller/Driver/getStudents.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStudent extends GetxController {
  DriverGetStudents getStudents = Get.find();
  DriverGetRides ride = Get.find();

  addStudent() async {
    Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    var res = await APIServices().put(
        APIConfig.addStudent +
            '?rideId=${ride.currentRide.value.id}&studentId=${getStudents.choosedStudent.value.id}',
        body: {});
   print(res.body);
   Get.back();
  }
}
