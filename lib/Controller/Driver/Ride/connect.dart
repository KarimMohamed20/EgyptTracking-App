import 'package:app/Controller/API/config.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:app/Models/User/userController.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverConnectRide {
  UserController _userController = Get.find();
  DriverGetRides _getRides = Get.find();

  IO.Socket connect() {
    var socket = IO.io(APIConfig.wsRide, <String, dynamic>{
      'path': '/socket.io',
      'transports': ['websocket'],
      'query':
          'rideId=${_getRides.currentRide.value.id}&token=${_userController.user.value.token}'
    });
    socket.on(
      'disconnect',
      (_) => print('disconnect'),
    );
    return socket;
  }

  sendAlert(studentId) async {
    var socket = IO.io(APIConfig.wsRide, <String, dynamic>{
      'path': '/socket.io',
      'transports': ['websocket'],
      'query':
          'rideId=${_getRides.currentRide.value.id}&token=${_userController.user.value.token}'
    });

    socket.emit("alert","{'studentId':$studentId,'driverName':${_userController.user.value.fullName}}");
    socket.on(
      'disconnect',
      (_) => print('disconnect'),
    );
    socket.destroy();
    socket.dispose();
    return 'Sent Successfully!';
  }
}