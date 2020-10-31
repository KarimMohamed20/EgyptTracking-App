import 'package:app/Models/User/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatItem extends StatefulWidget {
  final senderId;
  final message;

  ChatItem({this.senderId, this.message});

  @override
  _ChatMessageListItemState createState() => _ChatMessageListItemState();
}

class _ChatMessageListItemState extends State<ChatItem> {
  UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        children: widget.senderId == _userController.user.value.id
            ? getSentMessageLayout()
            : getReceivedMessageLayout(),
      ),
    );
  }

  List<Widget> getSentMessageLayout() {
    return <Widget>[
      new Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width / 2.5,
                padding: EdgeInsets.all(4),
                child: new Text(widget.message,
                    style: new TextStyle(
                      fontSize: 19.5,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              new CircleAvatar(
                child: Icon(Icons.person,
                color: Colors.white,),
                radius: 17,
                backgroundColor: Colors.blue,
              )
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> getReceivedMessageLayout() {
    return <Widget>[
      new Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new CircleAvatar(
                child: Icon(Icons.person,color: Colors.white,),
                radius: 17,
                backgroundColor: Colors.grey,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(4),
                child: new Text(
                  widget.message,
                  style: new TextStyle(
                    fontSize: 19.5,
                    color: Colors.white,
                  ),
                  maxLines: 99,
                  overflow: TextOverflow.ellipsis,

                ),
              )
            ],
          ),
        ),
      ),
    ];
  }
}
