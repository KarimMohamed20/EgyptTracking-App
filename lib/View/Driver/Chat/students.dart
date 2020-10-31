import 'package:app/Controller/Chat/chat.dart';
import 'package:app/Controller/Driver/getStudents.dart';
import 'package:app/Models/User/user.dart';
import 'package:app/View/Driver/Chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetChatStudents extends StatefulWidget {
  @override
  _GetStudentsState createState() => _GetStudentsState();
}

class _GetStudentsState extends State<GetChatStudents> {
  DriverGetStudents _getStudents = Get.put(DriverGetStudents());
  ChatController _chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    _getStudents.getStudents();
  }

  messageStudent(studentId) async {
    // Student Id
    _chatController.studentOrDriverId.value = studentId;
    _chatController.studentOrDriverId.refresh();
    await _chatController.getChat();

    Get.to(ChatScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: Obx(() {
        if (_getStudents.status.value == 'loading') {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (_getStudents.status.value == 'empty') {
          return Center(
            child: Text('Currently you don\'t have students.'),
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
                            onTap: () => messageStudent(student.id),
                            child: Icon(Icons.message)),
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
    );
  }
}
