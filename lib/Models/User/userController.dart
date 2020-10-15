import 'dart:convert';

import 'package:app/Models/User/user.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  Rx<UserModel> user = UserModel().obs;

  addData() async {
    var _prefs = await SharedPreferences.getInstance();
    var userString = _prefs.get("user");
    user.value = jsonDecode(userString);
    user.refresh();
    print(user.value.token);
  }
}
