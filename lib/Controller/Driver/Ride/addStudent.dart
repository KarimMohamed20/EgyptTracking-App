import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:app/Controller/Driver/getStudents.dart';
import 'package:get/get.dart';

class AddStudent extends GetxController {
  DriverGetStudents getStudents = Get.find();
  DriverGetRides getRides = Get.find();

  addStudent() async {
    await APIServices().put(
        APIConfig.addStudent +
            '?rideId=${getRides.currentRide.value.id}&studentId=${getStudents.choosedStudent.value.id}',
        body: {});
  }
}
