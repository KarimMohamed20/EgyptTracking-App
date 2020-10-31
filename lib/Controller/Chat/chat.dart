import 'dart:convert';
import 'package:app/Controller/API/apiServices.dart';
import 'package:app/Controller/API/config.dart';
import 'package:app/Models/User/userController.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxString studentOrDriverId = ''.obs;
  RxString chatId = ''.obs;
  RxList studentChats = [].obs;
  RxList messages = [].obs;
  UserController _userController = Get.find();
  getChat() async {
    var res = await APIServices().post(APIConfig.singleChat,
        body: _userController.user.value.accountType == "Student"
            ? {"driverId": studentOrDriverId.value}
            : {"studentId": studentOrDriverId.value});
    print(res.body);
    messages.value = jsonDecode(res.body)['chatMessages']['messages'];
    chatId.value = jsonDecode(res.body)['chatId'];
    chatId.refresh();
    messages.refresh();
  }

  getStudentChats() async {
    var res = await APIServices().get(APIConfig.studentChats);
    studentChats.value = jsonDecode(res.body)['chats'];
    studentChats.refresh();
  }
}
