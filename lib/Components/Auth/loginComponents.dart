import 'package:app/Controller/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginComponents {
  LoginController _loginController = Get.put(LoginController());
  var selectedType = 'Student'.obs;
  headerLogo() {
    return Container(
      height: Get.mediaQuery.size.height / 1.6,
      width: Get.mediaQuery.size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/splash_logo.png",
              scale: 1.5,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "FocusEMS",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 21,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splash.png'), fit: BoxFit.fill)),
    );
  }

  loginType() {
    // Login Type
    return Container(
      height: 70,
      child: Row(
        children: <Widget>[
          // Student
          _userType(image: 'login_student', name: 'Student'),
          //   Driver
          _userType(image: 'login_driver', name: "Driver"),

          _userType(
              image: Icon(
                Icons.navigate_next,
                size: 30,
                color: Colors.white,
              ),
              name: "Register",
              disableOnTap: (){
                Get.toNamed('/register');
              })
        ],
      ),
    );
  }

  loginFields() {
    return Expanded(
      flex: 2,
      child: Container(
        color: Color.fromRGBO(237, 246, 255, 1),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Wrap(),
            ),
            Text(
              "Get Started",
              style: TextStyle(
                fontSize: 19,
                color: Color.fromRGBO(235, 158, 26, 1),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            _loginInput(
                hint: "Email",
                icon: Icons.email,
                controller: _loginController.emailTextController),
            _loginInput(
                hint: 'Password',
                icon: Icons.lock,
                obscure: true,
                controller: _loginController.passwordTextController),
            Expanded(
              child: Wrap(),
            ),
          ],
        ),
      ),
    );
  }

  _userType({image, name, disableOnTap}) {
    return Expanded(
      child: InkWell(
          onTap: () {
            if (disableOnTap == null) {
              if (selectedType.value != name) {
                selectedType.value = name;
                selectedType.refresh();
              }
            } else {
              disableOnTap();
            }
          },
          child: Obx(
            () => Container(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5.5),
                      image.runtimeType != String
                          ? image
                          : Image.asset("assets/images/$image.png",
                              width: 30, height: 30, color: Colors.white),
                      SizedBox(height: 5),
                      Text(name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              color: selectedType.value == name
                  ? Color.fromRGBO(233, 66, 74, 1)
                  : Color.fromRGBO(27, 114, 194, 1),
              width: Get.width / 2,
            ),
          )),
    );
  }

  _loginInput(
      {String hint,
      IconData icon,
      TextEditingController controller,
      bool obscure = false}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color.fromRGBO(237, 246, 255, 1),
          )),
      child: TextFormField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            prefixIcon: Icon(
              icon,
              color: Color.fromRGBO(27, 114, 194, 1),
            )),
      ),
      height: 45,
    );
  }

  loginButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              _loginController.login();
            },
            child: Container(
              height: 50,
              child: Center(
                  child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
              color: Color.fromRGBO(235, 158, 26, 1),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          height: 50,
          width: Get.width / 2.5,
          child: Center(
              child: Text(
            "Forgot Password",
            style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
          color: Color.fromRGBO(199, 130, 13, 1),
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
