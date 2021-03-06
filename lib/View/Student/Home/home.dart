import 'dart:convert';

import 'package:app/Components/Student/drawer.dart';
import 'package:app/Components/Student/homeTiles.dart';
import 'package:app/Controller/Student/User/websocket.dart';
import 'package:app/Models/User/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_call_alert/in_app_call_alert.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class StudentHome extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<StudentHome> {
  UserController _userController = Get.find();
  List _clicked = List();
  IO.Socket currentSocket;
  @override
  void initState() {
    super.initState();
    connectAndListen();
  }

  connectAndListen() {
    currentSocket = StudentConnect().connect();
    setState(() {});
    currentSocket.on(_userController.user.value.id, (data) {
      print(data.runtimeType);
      Get.to(CallAlert(
          callerName: data['driverName'],
          ringtonePath: 'ringtone.mp3'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          drawer: StudentDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 180,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.pink[200],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    _userController.user.value.user == null
                                        ? ''
                                        : _userController.user.value.fullName,
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.white),
                                  )
                                ],
                              ),
                              color: Color.fromRGBO(160, 78, 163, 1),
                            ),
                          )),
                          HomeComponents().gridItem('assignment_dash',
                              'Assignments', Color.fromRGBO(246, 105, 114, 1))
                        ],
                      ),
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ],
                ),
                Container(
                  height: 110,
                  child: Row(
                    children: <Widget>[
                      HomeComponents().gridItem('holidays', 'Holiday',
                          Color.fromRGBO(128, 182, 106, 1)),
                      HomeComponents().gridItem('messages', 'Messages',
                          Color.fromRGBO(249, 168, 37, 1),onTap: ()=> Get.toNamed('/student/messages'),),
                      HomeComponents().gridItem(
                          'feeds', 'Feeds', Color.fromRGBO(128, 182, 106, 1))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                listTile(
                    title: 'Today Schedule',
                    image: "todayshedule.png",
                    type: 'today'),
                listTile(
                    title: 'Attendance',
                    image: "attendance.png",
                    type: 'attendance'),
                listTile(
                    title: 'Assignments',
                    image: "assignments.png",
                    type: 'assignments'),
                listTile(
                    title: 'Exam Schedule',
                    image: "examshedule.png",
                    type: 'examshedule'),
                listTile(
                    title: 'Marks in Exam', image: "marks.png", type: 'mark'),
              ],
            ),
          ),
        ));
  }

  Widget listTile({title, @required image, type}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: _clicked.contains(type)
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/" + image,
                            height: 30,
                            width: 30,
                          ),
                          Container(
                            child: Text(
                              title,
                              style: TextStyle(fontSize: 20),
                            ),
                            width: MediaQuery.of(context).size.width < 409
                                ? 170
                                : 260,
                          ),
                          InkWell(
                            onTap: () {
                              if (_clicked.contains(type)) {
                                _clicked.remove(type);
                                print("Remove");
                                setState(() {});
                              } else {
                                _clicked.add(type);
                                print('Add');
                                setState(() {});
                              }
                            },
                            child: Icon(
                              _clicked.contains(type) == true
                                  ? Icons.remove
                                  : Icons.add,
                              color: Color.fromRGBO(128, 182, 106, 1),
                            ),
                          )
                        ],
                      ),
                      type == "mark"
                          ? ListTile(
                              title: Text(type),
                              subtitle: Text(type),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.timer,
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                  Text("12 Sep, 2018")
                                ],
                              ),
                            )
                          : Padding(
                              child:
                                  Text('There is no available data right now'),
                              padding: EdgeInsets.all(5),
                            )
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/" + image,
                        height: 30,
                        width: 30,
                      ),
                      Container(
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 20),
                        ),
                        width:
                            MediaQuery.of(context).size.width < 409 ? 170 : 260,
                      ),
                      InkWell(
                        onTap: () {
                          if (_clicked.contains(type)) {
                            _clicked.remove(type);
                            print("Remove");
                            setState(() {});
                          } else {
                            _clicked.add(type);
                            print('Add');
                            setState(() {});
                          }
                        },
                        child: Icon(
                          _clicked.contains(type) == true
                              ? Icons.remove
                              : Icons.add,
                          color: Color.fromRGBO(128, 182, 106, 1),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
