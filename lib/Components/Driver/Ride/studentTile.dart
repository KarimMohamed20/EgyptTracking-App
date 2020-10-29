import 'package:app/Models/User/user.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatefulWidget {
  final onCall;
  final arrive;
  final UserModel student;
  StudentTile({this.onCall, this.arrive, @required this.student});
  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  UserModel get student => widget.student;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(student.fullName),
        subtitle: Icon(Icons.call),
        trailing: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            color: Colors.blue,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.control_point,
                  color: Colors.white,
                  size: 18,
                ),
                Text(
                  ' Arrive',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        leading: CircleAvatar(
          radius: 22,
          child: Icon(
            Icons.person,
            size: 22,
          ),
        ),
      ),
    );
  }
}
