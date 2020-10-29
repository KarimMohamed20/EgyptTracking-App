import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:app/Models/Ride/ride.dart';
import 'package:get/get.dart';

class ArriveController {
  DriverGetRides _rideModel = Get.find();
  Future arrive(String studentId) async {
    var res = await APIServices().put(
      APIConfig.arriveStudent +
          '?rideId=${_rideModel.currentRide.value.id}&studentId=$studentId',
      body: {},
    );
    print(res.body);
    return res;
  }
}
