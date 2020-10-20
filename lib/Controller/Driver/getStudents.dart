import 'dart:convert';
import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Models/User/user.dart';
import 'package:get/get.dart';

class DriverGetStudents extends GetxController {
  RxList<dynamic> students = [].obs;
  Rx<UserModel> choosedStudent = UserModel().obs;
  RxString status = 'loading'.obs;

  getStudents({bool refresh = false}) async {
    if (refresh == true) {
      var res = await APIServices().get(APIConfig.students);
      var body = jsonDecode(res.body);
      if (body == []) {
        status.value = 'empty';
        status.refresh();
      } else {
        status.value = 'success';
        students.value = body;
        students.refresh();
        status.refresh();
      }
    }
    if (students != []) {
      var res = await APIServices().get(APIConfig.students);
      var body = jsonDecode(res.body);
      if (body == []) {
        status.value = 'empty';
        status.refresh();
      } else {
        status.value = 'success';
        students.value = body;
        students.refresh();
        status.refresh();
      }
    }
  }
}
