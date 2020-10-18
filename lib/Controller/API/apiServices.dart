import 'dart:convert';
import 'package:app/Models/User/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIServices {
  UserController _userController = Get.find();

  Future<http.Response> post(url, {@required body}) async {
    var res = await http.post(url, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Authorization": _userController.user.value.token
    });
    return res;
  }

  Future<http.Response> get(url) async {
    var res = await http.get(url, headers: {
      "Authorization": _userController.user.value.token
    });

    return res;
  }
}
