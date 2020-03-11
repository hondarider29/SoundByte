import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_byte/model/user.dart';

class Chat
{
  String chatId;
  List<String> participants = [];
  
  /// Creates a new chat based on a given user ID
  Chat(String userId)
  {
    participants.add(User.currentUser.userID);
    participants.add(userId);

    try
    {
      Firestore.instance.collection('Chats')
        .where('participants', isEqualTo: [userId, User.currentUser.userID])
        .getDocuments().then((querySnapshot) =>
            chatId = querySnapshot.documents[0].documentID
          );
      Firestore.instance.collection('Chats')
        .where('participants', isEqualTo: [User.currentUser.userID, userId])
        .getDocuments().then((querySnapshot) =>
            chatId = querySnapshot.documents[0].documentID
          );
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  /// Creates a new chat on Firebase using the given user ID
  /// Not really functional, so try to use only existing chats
  Chat.createNew(String uId)
  {
    participants.add(User.currentUser.userID);
    participants.add(uId);
    
    _createEntries();
  }

  /// Creates a chat based on a given chat ID
  Chat.fromId(String chatId)
  {
    this.chatId = chatId;

    _setParticipants(chatId);
  }

  /// Creates the entries in firebase for Chat.createNew()
  Future<void> _createEntries() async
  {
    await Firestore.instance.collection('Chats')
      .add({
        'participants': participants 
      });
    await Firestore.instance.collection('Chats')
      .where('participants', isEqualTo: participants)
      .getDocuments().then((query) =>
        chatId = query.documents[0].documentID
      );
    await Firestore.instance.collection('Chats')
      .document(chatId)
      .collection('Messages')
      .document()
      .setData({});
  }

  /// Gets the participants from firebase
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

  /// Returns the name of the user who is not the current user
  String getOtherUser()
  {
    String otherId = participants.firstWhere((user) =>
      user != User.currentUser.userID
    );
    return otherId;
  }

  bool operator ==(o) => this.chatId == o.chatId;

  int get hashCode => this.chatId.hashCode;
}