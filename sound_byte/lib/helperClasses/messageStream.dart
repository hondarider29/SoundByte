import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_byte/helperClasses/messageBubble.dart';
import 'package:sound_byte/model/user.dart';

final _firestore = Firestore.instance;

class MessagesStream extends StatefulWidget {
  final String chatID;

  MessagesStream(this.chatID);

  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Chats').document(widget.chatID).collection('Messages').orderBy('timesent').snapshots(),
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
            final senderId = message.data['senderID'];
            final senderText = User.currentUser.getUserName(senderId);
            final timeStamp = message.data['timesent'];

            final currentUser = User.currentUser.userID;

            //create a new message bubble widget to load
            if(messageText != null){
              messageBubbles.add(
                MessageBubble(
                  text: messageText,
                  sender: senderText,
                  timeStamp: timeStamp,
                  isMe: currentUser == senderId,
                ),
              );
            }
          }

          //actual displaying of the messages
          return Expanded(
            child: Container(
              child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: messageBubbles,
              ),
            ),
          );
        }
      },
    );
  }
}
