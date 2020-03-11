import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_byte/model/user.dart';

class Chat
{
  String chatId;
  List<String> participants = [];
  
  Chat(String userId)
  {
    participants.add(User.currentUser.userID);
    participants.add(userId);

    try
    {
      Firestore.instance.collection('Chats')
        .where('participants', arrayContains: userId)
        .where('participants', arrayContains: User.currentUser.userID)
        .getDocuments().then((querySnapshot) =>
            chatId = querySnapshot.documents[0].documentID
          );
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Chat.fromId(String chatId)
  {
    this.chatId = chatId;

    _setParticipants(chatId);
  }

  Future<void> _setParticipants(String chatId) async
  {
    try
    {
      DocumentSnapshot doc = await Firestore.instance.collection('Chats')
        .document(chatId)
        .get();

      participants = doc.data['participants'].cast<String>().toList();
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  String getOtherUser()
  {
    String otherId = participants.firstWhere((user) =>
      user != User.currentUser.userID
    );
    return otherId;
  }

  bool operator ==(o) => this.chatId == o.chatId;
}