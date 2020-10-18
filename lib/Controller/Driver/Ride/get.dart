import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Models/Ride/ride.dart';
import 'package:app/Models/User/userController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DriverGetRides extends GetxController {
  Rx<RideModel> rideModel = RideModel().obs;

  getMyRides() async {
    var res = APIServices().get(url, body: null);
  }
}
