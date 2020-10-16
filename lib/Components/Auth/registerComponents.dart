import 'package:app/Controller/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterComponents {
  RegisterController _registerController = Get.put(RegisterController());
  headerLogo() {
    return Container(
      height: Get.mediaQuery.size.height / 2,
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

  registerFields() {
    return Expanded(
      flex: 2,
      child: Container(
        color: Color.fromRGBO(237, 246, 255, 1),
        child: Column(
          children: <Widget>[
            Expanded(child: Wrap()),
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
            _registerField(
                hint: "Full Name",
                icon: Icons.text_fields,
                controller: _registerController.fullNameTextController),
            _registerField(
                hint: "Email",
                icon: Icons.email,
                controller: _registerController.emailTextController),
            Obx(()=>_locationField(
                hint: "Location",
                icon: Icons.location_pin,
                controller: TextEditingController(
                    text: _registerController.currentLocation.value.latitude.roundToDouble()
                            .toString() +
                        ", " +
                        _registerController.currentLocation.value.longitude.roundToDouble()
                            .toString())),),
            _registerField(
                hint: 'Password',
                icon: Icons.lock,
                obscure: true,
                controller: _registerController.passwordTextController),
            _registerField(
                hint: 'Confirm Password',
                icon: Icons.lock,
                obscure: true,
                controller: _registerController.confirmPasswordTextController),
            Expanded(child: Wrap()),
          ],
        ),
      ),
    );
  }

  _registerField(
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

  _locationField(
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
        onTap: (){
          Get.toNamed('/register/location');
        },
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

  registerButton() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _registerController.register();
          },
          child: Container(
            height: 50,
            child: Center(
                child: Text(
              "Register",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            color: Color.fromRGBO(235, 158, 26, 1),
            alignment: Alignment.bottomCenter,
          ),
        ),

      ],
    );
  }
}
