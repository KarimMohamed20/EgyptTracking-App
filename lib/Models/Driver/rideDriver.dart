class RideDriverModel {
  final Map driver;
  RideDriverModel({this.driver});

  String get id => driver['id'];
  String get fullName => driver['fullName'];
}
