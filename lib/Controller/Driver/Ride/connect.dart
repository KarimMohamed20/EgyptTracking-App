import 'package:adhara_socket_io/adhara_socket_io.dart';

class DriverConnectRide {
  connect(String rideId, String token) async {
    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance(SocketOptions(
      //Socket IO server URI
      'ws://192.168.1.2:3000/ride', //?token,=$token&rideId=$rideId',
      //Query params - can be used for authentication
      path: '/socket.io',
      query: {"token": token, "rideId": rideId},
      //  Enable or disable platform channel logging
      enableLogging: true,
    ));
    await socket.connect();
    socket.on(rideId, (data) {
      print(data);
    });
  }
}
