import 'package:app/Models/User/userController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController {
  UserController _loginController = Get.find();
  logOut() async {
    _navigateLogin();
    await _removePrefs();
    _removeCreds();
  }

  _removeCreds() {
    _loginController.user.value.user = null;
    _loginController.user.value.token = null;
    _loginController.user.refresh();
  }

  _removePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('user');
    await prefs.remove('token');
  }

  _navigateLogin() {
    Get.toNamed('/');
  }
}
