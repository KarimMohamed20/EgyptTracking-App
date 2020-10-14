class StudentModel {
  Map user;
  StudentModel({this.user});

  String get id => user['id'];
  String get fullName => user['fullName'];
  String get email => user['email'];
  String get lat => user['lat'];
  String get lng => user['lng'];
  String get accountType => user['accountType'];
  String get currentRideId => user['currentRideId'];
  String get createdAt => user['createdAt'];
  String get updatedAt => user['updatedAt'];
}
