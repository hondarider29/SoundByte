import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_byte/helperClasses/messageBubble.dart';

final _firestore = Firestore.instance;

class MessagesStream extends StatefulWidget {
  final String userID;
  final String friendID;

  MessagesStream(this.userID, this.friendID);

  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {

  String saveChatID;

  @override
  void initState() {
    getChatID();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //TODO: change firestore collection to be actual ones. Here lie demos
      stream: _firestore.collection('Chats').document(saveChatID).collection('Messages').orderBy('timesent').snapshots(),
      builder: (context, snapshot) {
        //loading screen
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
          //load messages
        } else {
          //pull messages in reverse so newest come first
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data['data'];
            final senderText = message.data['senderID'];
            final timeStamp = message.data['timesent'];

            final currentUser = widget.userID;

            //create a new message bubble widget to load
            messageBubbles.add(
              MessageBubble(
                text: messageText,
                sender: senderText,
                timeStamp: timeStamp,
                isMe: currentUser == senderText,
              ),
            );
          }

          //actual displaying of the messages
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
            ),
          );
        }
      },
    );
  }

  getChatID() async{
    if(widget.userID != "" && widget.friendID != ""){
      print("User ID: " + widget.userID);
      print("Friend ID: " + widget.friendID);
      DocumentSnapshot snapshot = await _firestore.collection('Users').document(widget.userID).collection('Chats').document(widget.userID + "-" + widget.friendID).get();
      setState(() {
          saveChatID = snapshot.data['chatID'];
      });
      //return snapshot.data['chatID'];
    }else{
      print("ERROR with id for chatID");
    }
  }
}