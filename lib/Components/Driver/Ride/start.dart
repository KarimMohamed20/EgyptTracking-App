import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartRideComponents {
  startOrEnd(hint,Function onTap) {
    return Padding(
      padding: EdgeInsets.all(65.0),
      child: Container(
        height: 60,
        child: RaisedButton(
            color: Color.fromRGBO(27, 114, 194, 1),
            child: Center(
                child: Text(
              hint,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            )),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              onTap();
            }),
      ),
    );
  }
}
