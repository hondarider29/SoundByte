import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:sound_byte/pages/chatScreen.dart';
import 'package:sound_byte/model/user.dart';

//screen to see all recent chats with friends and access to contact list
class ChatList extends StatefulWidget {
 @override
  ChatList({Key key, this.auth, this.logoutCallback})
      : super(key: key); 

  _ChatListState createState() => _ChatListState();
  final BaseAuth auth;
  final VoidCallback logoutCallback;
}

class _ChatListState extends State<ChatList> {
  TextEditingController nameTextController;
  List<Widget> list = [];

  @override
  void initState() {
    nameTextController = new TextEditingController();
    super.initState();
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Firestore.instance.collection('Chats')
      .where("participants", arrayContains: User.currentUser.userID)
      .getDocuments().then((querySnapshot) =>
        querySnapshot.documents.forEach((document) =>
          list.add(chatButton(
            document.documentID,
            document.data['participants'].singleWhere((id) => id != User.currentUser.userID))
          )
        )
      );
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        title: Text('Byte Chat'),
        //title: Text(),
        actions: <Widget>[
          FlatButton(child: Text('Logout',
            key: Key('logOut'),
            style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: signOut
          )
        ],
      ),
      //list of all contacts and search
      //IDEA: maybe turn into a stream
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9],
            colors: [
              Colors.lightBlueAccent,
              Colors.blue,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 16),

              //friend list
              ListView.builder(
                itemCount: User.currentUser == new User.nullUser() ? 0 : User.currentUser.friends.length,
                itemBuilder: (BuildContext context, int index) {
                  return list[index];
                },
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //creates a button displaying all the information about a friend
  Widget chatButton(String chatId, String friendId) {
    double size = 50;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white, style: BorderStyle.solid, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(chatId),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //image of friend
                Container(
                  
                  child: RaisedButton(
                    //shape: RoundedRectangleBorder(
                    //borderRadius: new BorderRadius.circular(18),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)
                    ),
                    //),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(chatId),
                        ),
                      );
                    },
                    padding: EdgeInsets.all(0),
                    //child: Image.asset(imageName),
                  ),
                  width: size,
                  height: size,
                ),
                SizedBox(width: 8),
                //name and part of last sent text message
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      User.currentUser.getFriendName(friendId),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Montserrat'
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

