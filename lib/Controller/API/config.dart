class APIConfig {
  static final baseUrl = 'http://192.168.1.5:3000/api/v1';
  static final wsUrl = 'ws://192.168.1.5:3000';

  // APIs
  static final login = baseUrl + '/login';
  static final register = baseUrl + '/register';
  static final driverRides = baseUrl + '/ride/get';
  static final createRide = baseUrl + '/ride/create';
  static final students = baseUrl + '/students';
  static final addStudent = baseUrl + '/ride/addStudent';
  static final startRide = baseUrl + '/ride/start';
  static final getStudentRide = baseUrl + '/ride/student/get';

  // Websockets
  static final wsRide = wsUrl + '/ride';
}