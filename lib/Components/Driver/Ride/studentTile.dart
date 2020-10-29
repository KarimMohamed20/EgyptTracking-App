import 'package:app/Models/User/user.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatefulWidget {
  final onCall;
  final Function arrive;
  final UserModel student;
  StudentTile({this.onCall, this.arrive, this.student});
  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  UserModel get student => widget.student;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(student.fullName),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Align(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: widget.arrive,
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                     student.user['arrived'] == false ? Icons.add :   Icons.remove,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text(
                       student.user['arrived'] == false ? ' Add to BUS' : ' Remove from BUS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
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
          Divider(
            height: 0.5,
            color: Colors.grey[700],
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
