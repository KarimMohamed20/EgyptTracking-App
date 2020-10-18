import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideCreateComponents  {
  logo() {
    return Container(
      height: Get.mediaQuery.size.height / 1.6,
      width: Get.mediaQuery.size.width,
      child: Column(
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/splash_logo.png",
              scale: 1.7,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "FocusEMS",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 19,
                fontWeight: FontWeight.w500),
          )
        ],
      ));
  }

  createForm() {
    return Column(
      children: [
        _formField(),
        _formField(),
        _formField(),
        _formField(),
      ],
    );
  }
  _formField({String hint,TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint,
      border: OutlineInputBorder()),
    );
  }
}