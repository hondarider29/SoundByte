import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sound_byte/helperClasses/messageStream.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;

//screen to display and send all chats
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextController;
  String messageText = '';
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    getCurrentUser();
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Byte Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      //messages and chat bar
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MessagesStream("test2@test.com"),
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
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message here...',
                      contentPadding: EdgeInsets.all(12.0),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection('Messages').add({
                      'Messages': messageText,
                      'Sender': loggedInUser.email,
                      'TimeSent': DateTime.now(),
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

  void getCurrentUser() async {
    final user = await _auth.currentUser();
    if (user != null) {
      try {
        loggedInUser = user;
        print(loggedInUser.email);
      } catch (e) {
        print(e);
      }
    }
  }
}
