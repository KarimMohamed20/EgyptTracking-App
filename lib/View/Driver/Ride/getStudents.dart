import 'package:app/Controller/Driver/Ride/addStudent.dart';
import 'package:app/Controller/Driver/Ride/get.dart';
import 'package:app/Controller/Driver/getStudents.dart';
import 'package:app/Models/User/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStudents extends StatefulWidget {
  @override
  _GetStudentsState createState() => _GetStudentsState();
}

class _GetStudentsState extends State<GetStudents> {
  DriverGetStudents _getStudents = Get.put(DriverGetStudents());
  DriverGetRides ride = Get.find();

  @override
  void initState() {
    super.initState();

    _getStudents.getStudents();
  }

  removeOrAddStudent(student) async {
    _getStudents.choosedStudent.value = student;
    _getStudents.choosedStudent.refresh();
    await AddStudent().addStudent();
    _getStudents.getStudents(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Remove Student"),
      ),
      body: Column(
        children: [
          Obx(() {
            if (_getStudents.status.value == 'loading') {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (_getStudents.status.value == 'empty') {
              return Center(
                child: Text('Currently you don\'t have students to add.'),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  _getStudents.getStudents(refresh: true);
                },
                child: Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: _getStudents.students.length,
                      itemBuilder: (context, i) {
                        var student = UserModel(user: _getStudents.students[i]);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            trailing: InkWell(
                              onTap: () => removeOrAddStudent(student),
                              child: Icon(
                                ride.currentRide.value.id ==
                                        student.currentRideId
                                    ? Icons.remove
                                    : Icons.add,
                                color: Colors.blue,
                                size: 28,
                              ),
                            ),
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
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
