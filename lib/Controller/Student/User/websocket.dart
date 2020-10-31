import 'package:app/Controller/API/config.dart';
import 'package:app/Models/User/userController.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class StudentConnect {
  UserController _userController = Get.find();

  IO.Socket connect() {
    var socket = IO.io(APIConfig.wsRide, <String, dynamic>{
      'path': '/socket.io',
      'transports': ['websocket'],
      'query':
          'rideId=${_userController.user.value.currentRideId}&token=${_userController.user.value.token}'
    });
    socket.on(
      'disconnect',
      (_) => print('disconnect'),
    );
    return socket;
  }
}
