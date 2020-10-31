import 'dart:convert';

import 'package:app/Components/Chat/chatTile.dart';
import 'package:app/Controller/Chat/chat.dart';
import 'package:app/Controller/Chat/websocket.dart';
import 'package:app/Models/User/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  @override
  _TeacherChatState createState() => _TeacherChatState();
}

class _TeacherChatState extends State<ChatScreen> {
  ChatController _chatController = Get.find();
  UserController _userController = Get.find();
  IO.Socket currentSocket;
  bool _isComposingMessage = false;
  TextEditingController messageController = TextEditingController();

  checkNsend() {
    String msg;
    msg = messageController.text.trim();
    // Checking TextField.
    if (msg.isEmpty) {
      print('✖ Message wasn\'t sent ✖');
      scrollToEnd();
    } else if (msg.isNotEmpty && msg != "") {
      print("Message was sent ✅");
      messageController.clear();
      scrollToEnd();

      sendToChat(msg);
      _isComposingMessage = false;
    }
  }

  ScrollController _scrollController = ScrollController();

  scrollToEnd() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  listenToChat() {
    currentSocket.on(_chatController.chatId.value, (data) {
      _chatController.messages.add(jsonDecode(data));
      _chatController.messages.refresh();
    });
  }

  sendToChat(message) {
    print(message);
    currentSocket.emit('message',
        '{"message":"$message","senderId":"${_userController.user.value.id}"}');
  }

  @override
  void initState() {
    super.initState();
    connectToSocket();
    
    listenToChat();
  }

  @override
  void dispose() {
    super.dispose();
    currentSocket.dispose();
    currentSocket.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Messages'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Obx(
                () => new Flexible(
                    child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _chatController.messages.length,
                  itemBuilder: (context, i) {
                    return ChatItem(
                      senderId: _chatController.messages[i]['senderId'],
                      message: _chatController.messages[i]['message'],
                    );
                  },
                )),
              ),
              new Divider(height: 1.0),
              new Container(
                decoration:
                    new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
              new Builder(builder: (BuildContext context) {
                return new Container(width: 0.0, height: 0.0);
              })
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border: new Border(
                      top: new BorderSide(
                  color: Colors.grey[200],
                )))
              : null,
        ));
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage ? () => checkNsend() : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Colors.blue
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: messageController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: (message) => _isComposingMessage = false,
                  decoration:
                      new InputDecoration.collapsed(hintText: 'Send Message'),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  void connectToSocket() {
    currentSocket = ConnectChat().connect();
    setState(() {});
  }
}
