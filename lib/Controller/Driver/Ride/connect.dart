import 'package:app/Controller/API/config.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:app/Models/User/userController.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverConnectRide {
  UserController _userController = Get.find();
  DriverGetRides getRides = Get.find();


  IO.Socket driverConnection() {
    var socket = IO.io(APIConfig.wsRide, <String, dynamic>{
      'path': '/socket.io',
      'transports': ['websocket'],
      'query':
          'rideId=${getRides.currentRide.value.id}&token=${_userController.user.value.token}'
    });
    socket.connect();
    socket.on('connect', (data) => print('Connected as a Driver!'));
    socket.on(
      'disconnect',
      (_) => print('disconnect'),
    );

    return socket;
  }
}
