import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_byte/model/user.dart';

class Chat
{
  String chatId;
  List<User> participants = [User.currentUser];
  
  Chat(String userId)
  {
    User.userFromDatabase(userId).then((user) =>
      participants.add(user)
    );

    Firestore.instance.collection('Chats')
      .where("participants", isEqualTo: userId)
      .getDocuments().then((querySnapshot) =>
          chatId = querySnapshot.documents[0].documentID
        );
  }

  Chat.fromId(String chatId)
  {
    Firestore.instance.collection('Chats')
      .document(chatId)
      .get().then((chat) =>
        _getParticipants(chat)
      );
  }

  void _getParticipants(DocumentSnapshot chat)
  {
    List<String> uIDs;

    uIDs = chat.data['participants'].cast<String>().toList();
    uIDs.forEach((uID) =>
      User.userFromDatabase(uID).then((user) =>
        participants.add(user)
      )
    );
  }

  User getOtherUser()
  {
    User other = participants.firstWhere((user) =>
      user.userID != User.currentUser.userID
    );
    return other; 
  }
}