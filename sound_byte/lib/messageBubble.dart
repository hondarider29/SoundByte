import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//creates a bubble with all the text from a message
class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.timeStamp, this.isMe});

  final String sender;
  final String text;
  final Timestamp timeStamp;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30) : Radius.zero,
              topRight: isMe ? Radius.zero : Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            elevation: 5,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
          Text(
            convert12(DateFormat('kk:mm').format(timeStamp.toDate())),
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  //converts a string dateTime into a 12 hour string
  String convert12(String dateTime){
    String meridien = '';
    String cout = '';

    int h1 = int.tryParse(dateTime[0]);
    int h2 = int.tryParse(dateTime[1]);

    int hh = h1 * 10 + h2;

    if(hh < 12){
      meridien = 'AM';
    }else{
      meridien = 'PM';
    }

    hh %= 12;

    if(hh == 0){
      cout += '12';

      for(int i = 2; i < 5; i++){
        cout += dateTime[i];
      }
    }else{
      cout += hh.toString();
      
      for(int i = 2; i < 5; i++){
        cout += dateTime[i];
      }
    }

    return cout + ' ' + meridien;
  }
}
