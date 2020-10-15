import 'dart:convert';

import 'package:app/Models/User/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  Rx<UserModel> user = UserModel().obs;

  Future addData() async {
    var _prefs = await SharedPreferences.getInstance();
    String userString = _prefs.get("user");
    var tokenString = _prefs.get("token");
    if (userString != null) {
      user.value = UserModel(user: jsonDecode(userString));
      user.value.token = tokenString;
      user.refresh();
      print(user.value.token);

    }
  }
}
