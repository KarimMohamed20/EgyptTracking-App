import 'package:app/Models/User/userController.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverConnectRide {
  UserController _userController = Get.find();

  IO.Socket driverConnection({
    String rideId,
  }) {
    var socket = IO.io('ws://localhost:3000/ride', <String, dynamic>{
      'path': '/socket.io',
      'transports': ['websocket'],
      'query': 'rideId=$rideId&token=${_userController.user.value.token}'
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
