import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

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
        title: Text("Students"),
      ),
      body: getRides.currentRide.value.students.isEmpty
          ? Center(
              child: Text("There is no students here, you can add students."),
            )
          : ListView.builder(
              itemCount: getRides.currentRide.value.students.length,
              itemBuilder: (context, i) {
                var student = getRides.currentRide.value.studentsObjects[i];
                print(student);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(student['fullName']),
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
