import 'package:app/Models/Driver/rideDriver.dart';

class RideModel {
  final Map ride;
  RideModel({this.ride});

  String get id => ride['id'];
  String get rideName => ride['rideName'];
  String get helperName => ride['helperName'];
  List<String> get students => ride['students'];
  List get studentsObjects => ride['studentsObjects'];
  RideDriverModel get driver => RideDriverModel(driver: ride['driver']);
  bool get started => ride['started'];
  String get createdAt => ride['createdAt'];
  String get updatedAt => ride['updatedAt'];
}
