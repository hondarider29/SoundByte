import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sound_byte/helperClasses/messageStream.dart';
import 'package:sound_byte/model/user.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;

//screen to display and send all chats
class ChatScreen extends StatefulWidget {
  final String chatID;

  ChatScreen(this.chatID);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextController;
  String messageText = '';

  @override
  void initState() {
    messageTextController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          key: Key("chatBack"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Byte Chat',
        style: TextStyle(
          fontFamily: 'Pop'
        ),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      //messages and chat bar
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MessagesStream(widget.chatID),
          Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(24.0)),
              color: Color(0x55ffffff),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    key: Key("chatBar"),
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Please enter a message...',
                      contentPadding: EdgeInsets.all(12.0),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  key: Key("sendMessage"),
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection('Chats').document(widget.chatID).collection('Messages').add({
                      'data': messageText,
                      'senderID': User.currentUser.userID,
                      'timesent': DateTime.now(),
                    });
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
