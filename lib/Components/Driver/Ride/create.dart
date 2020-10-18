import 'package:app/Controller/Driver/Ride/create.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideCreateComponents {
  DriverCreateRideController _driverCreateRideController =
      Get.put(DriverCreateRideController());
  logo() {
    return Container(
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
        _formField(
            hint: 'Ride Name',
            controller: _driverCreateRideController.rideName),
        _formField(
            hint: 'Helper Name',
            controller: _driverCreateRideController.helperName),
        _checkBox('Do you want to start your ride now?'),
      ],
    );
  }

  _checkBox(hint) {
    return Obx(() => CheckboxListTile(
      title: Text(hint),
        value: _driverCreateRideController.started.value,
        onChanged: (v) {
          _driverCreateRideController.started.value = v;
          _driverCreateRideController.started.refresh();
        }));
  }

  _formField({String hint, TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: hint, border: OutlineInputBorder()),
      ),
    );
  }

  submitButton() {
    return RaisedButton(onPressed: (){
      _driverCreateRideController.createRide();
    },
    child: Text("Create Ride",
    style: TextStyle(
      color: Colors.white,
      fontSize: 19
    ),),
    elevation: 10,
    color: Colors.blue[600],
    padding: EdgeInsets.symmetric(vertical:12,horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22)
    ),);
  }
}
