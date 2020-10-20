import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:app/Models/User/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideStudents extends StatefulWidget {
  @override
  _RideStudentsState createState() => _RideStudentsState();
}

class _RideStudentsState extends State<RideStudents> {
  DriverGetRides getRides = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('/students');
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          )
        ],
        title: Text("Students"),
      ),
      body: getRides.currentRide.value.students.isEmpty
          ? Center(
              child: Text("There is no students here, you can add students."),
            )
          : ListView.builder(
              itemCount: getRides.currentRide.value.students.length,
              itemBuilder: (context, i) {
                var student = UserModel(user:getRides.currentRide.value.studentsObjects[i]);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(student.fullName),
                    leading: CircleAvatar(
                      radius: 22,
                      child: Icon(
                        Icons.person,
                        size: 22,
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
