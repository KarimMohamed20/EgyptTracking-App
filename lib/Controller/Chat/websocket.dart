import 'package:app/Controller/API/config.dart';
import 'package:app/Controller/Chat/chat.dart';
import 'package:app/Models/User/userController.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ConnectChat {
  UserController _userController = Get.find();
  ChatController _chatController = Get.find();

  IO.Socket connect() {
    var socket = IO.io(APIConfig.wsChat, <String, dynamic>{
      'path': '/socket.io',
      'transports': ['websocket'],
      'query': _userController.user.value.accountType == "Student"
              ? 'driverId=${_chatController.studentOrDriverId.value}&token=${_userController.user.value.token}'
              : 'studentId=${_chatController.studentOrDriverId.value}&token=${_userController.user.value.token}' 
    });
    socket.on(
      'disconnect',
      (_) => print('disconnect'),
    );
    return socket;
  }
}
