import 'dart:convert';

import 'package:app/Controller/API/config.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIServices {
  Future post(url, {@required body}) async {
    var prefs = await SharedPreferences.getInstance();
    var res = await http.post(url, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Authorization": prefs.getString('accessToken')
    });
    return res;
  }

  Future get(url, {@required body}) async {
    var prefs = await SharedPreferences.getInstance();
    var res = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": prefs.getString('accessToken')
    });

    return res;
  }
}
