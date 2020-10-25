import 'dart:convert';
import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:get/get.dart';

class StartRideController {
  DriverGetRides rideStudents = Get.find();
  Future startRide(bool isStart) async {
    var res = await APIServices().put(
        APIConfig.startRide + "?rideId=${rideStudents.currentRide.value.id}",
        body: {});
    print(res.body);

    if(isStart == true) {
      Get.toNamed('/driver/currentRide');
    } else {
      Get.toNamed('/driver/home');
    }
    return jsonDecode(res.body);
  }
}
