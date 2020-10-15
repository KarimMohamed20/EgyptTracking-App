import 'package:flutter/material.dart';

class NullOrNot {
  String isNull(dynamic value, String string) {
    print(value.runtimeType);
   //if (value == null) {
   //   return '';
   // } else {
      return 'string';
   // }
  }

  isNullWidget(dynamic value, Widget widget) {
    if (value == null) {
      return Wrap();
    } else {
      return widget;
    }
  }
}
