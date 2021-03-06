import 'dart:convert';

import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Models/Ride/ride.dart';
import 'package:get/get.dart';

class DriverGetRides extends GetxController {
  RxList<dynamic> rides = [].obs;
  Rx<RideModel> currentRide = RideModel(ride: {}).obs;
  RxString status = 'loading'.obs;

  getMyRides({bool refresh = false}) async {
    if (refresh == true) {
      var res = await APIServices().get(APIConfig.driverRides);
      var body = jsonDecode(res.body);
      if (body == []) {
        status.value = 'empty';
        status.refresh();
      } else {
        status.value = 'success';
        rides.value = body;
        rides.refresh();
        status.refresh();
      }
    }
    if (rides != []) {
      var res = await APIServices().get(APIConfig.driverRides);
      var body = jsonDecode(res.body);
      if (body == []) {
        status.value = 'empty';
        status.refresh();
      } else {
        status.value = 'success';
        rides.value = body;
        rides.refresh();
        status.refresh();
      }
    }
  }
}
