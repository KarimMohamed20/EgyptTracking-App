import 'package:socket_io_client/socket_io_client.dart' as IO;
class DriverConnectRide {


  IO.Socket driverConnection({String rideId,}) {
    var driverToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNWY4MjRhNjVhOWIzYTliNmVmZDdmYTNmIn0sImlhdCI6MTYwMjU1OTY1OCwiZXhwIjoxNjM0MDk1NjU4fQ.EY2od4e2dQgog0nJqmWxkQIObDRV2rrnXU4etWYTAiU';
    var socket = IO.io('ws://localhost:3000/ride', <String, dynamic>{
      'path': '/socket.io',
      'transports': ['websocket'],
      'query': 'rideId=$rideId&token=$driverToken'
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
