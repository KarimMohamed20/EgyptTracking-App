import 'dart:convert';

import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Models/Ride/ride.dart';
import 'package:get/get.dart';

class StudentGetRides extends GetxController {
  Rx<RideModel> ride = RideModel().obs;
  RxString loading = 'loading'.obs;
  RxInt statusCode = 200.obs;
  getRide() async {
    var res = await APIServices().get(APIConfig.getStudentRide);
    ride.value = RideModel(ride: jsonDecode(res.body));
    loading.value = 'done';
    ride.refresh();
    statusCode.value = res.statusCode;
    loading.refresh();
  }
}
