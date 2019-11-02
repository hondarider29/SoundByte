import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_byte/messageBubble.dart';
=======
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:sound_byte/messageBubble.dart';
>>>>>>> committing to rebase

//final _firestore = Firestore.instance;
//FirebaseUser loggedInUser;

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  //   return StreamBuilder<QuerySnapshot>(
  //     //TODO: change firestore collection to be actual ones. Here lie demos
  //     stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
  //     builder: (context, snapshot) {
  //       //loading screen
  //       if (!snapshot.hasData) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             backgroundColor: Colors.lightBlueAccent,
  //           ),
  //         );
  //       //load messages
  //       } else {
  //         //pull messages in reverse so newest come first
  //         final messages = snapshot.data.documents.reversed;
  //         List<MessageBubble> messageBubbles = [];
  //         for (var message in messages) {
  //           final messageText = message.data['text'];
  //           final senderText = message.data['sender'];
  //           final timeStamp = message.data['timestamp'];

<<<<<<< HEAD
            //final currentUser = loggedInUser.email;

            //create a new message bubble widget to load
          //   messageBubbles.add(
          //     MessageBubble(
          //       text: messageText,
          //       sender: senderText,
          //       timeStamp: timeStamp,
          //       //isMe: currentUser == senderText,
          //     ),
          //   );
          // }
=======
  //           final currentUser = loggedInUser.email;

  //           //create a new message bubble widget to load
  //           messageBubbles.add(
  //             MessageBubble(
  //               text: messageText,
  //               sender: senderText,
  //               timeStamp: timeStamp,
  //               isMe: currentUser == senderText,
  //             ),
  //           );
  //         }
>>>>>>> committing to rebase

  //         //actual displaying of the messages
  //         return Expanded(
  //           child: ListView(
  //             reverse: true,
  //             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
  //             children: messageBubbles,
  //           ),
  //         );
  //       }
  //     },
  //   );
<<<<<<< HEAD
  }
=======
   }
>>>>>>> committing to rebase
}
