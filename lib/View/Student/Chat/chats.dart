import 'package:app/Controller/Chat/chat.dart';
import 'package:app/View/Driver/Chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatStudents extends StatefulWidget {
  @override
  _GetStudentsState createState() => _GetStudentsState();
}

class _GetStudentsState extends State<ChatStudents> {
  ChatController _getChats = Get.put(ChatController());
  ChatController _chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    _getChats.getStudentChats();
  }

  messageDriver(driverId) async {
    // Student Id
    _chatController.studentOrDriverId.value = driverId;
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
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Obx(() {
          if (_chatController.studentChatStatus.value == 'loading') {
            return Center(
              child: CircularProgressIndicator(),
            );
          }  else {
            return RefreshIndicator(
              onRefresh: () async {
                _chatController.getStudentChats();
              },
              child: Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: _chatController.studentChats.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          trailing: InkWell(
                              onTap: () => messageDriver(_chatController.studentChats[i]['driverId']),
                              child: Icon(Icons.message)),
                          title: Text(_chatController.studentChats[i]['driverName']),
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
      ),
    );
  }
}
