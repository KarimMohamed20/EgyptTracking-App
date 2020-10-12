import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverConnectRide {
  connect(String rideId, String token) async {
    IO.Socket socket =
        IO.io('ws://localhost:3000/ride?rideId=$rideId&token=$token');
    socket.on('connect', (_) {
      print(_);
    });
  }
}
