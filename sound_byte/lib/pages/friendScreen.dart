import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_byte/pages/chatScreen.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:sound_byte/pages/friendProfile.dart';
import 'package:sound_byte/model/user.dart';

//screen to see all recent chats with friends and access to contact list
class FriendScreen extends StatefulWidget {
 @override
  FriendScreen({Key key, this.auth, this.logoutCallback})
      : super(key: key); 

  _FriendScreenState createState() => _FriendScreenState();
  final BaseAuth auth;
  final VoidCallback logoutCallback;
}

class _FriendScreenState extends State<FriendScreen> {
  TextEditingController nameTextController;
  List<String> ids = User.currentUser.friends;
  List<String> searchNames;

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
              //friend search bar bar
              Container(
                child: TextField(
                  onSubmitted: (String input) {
                    if (input == "")
                    {
                      setState(() =>
                        ids = User.currentUser.friends
                      );
                    }
                    else
                    {
                      Firestore.instance.collection('Users')
                        .where("name", isEqualTo: input)
                        .getDocuments().then(
                          (querySnapshot) =>
                            setState(()
                            {
                              ids = new List.from([querySnapshot.documents[0].documentID]);
                              searchNames = new List.from([querySnapshot.documents[0].data['name']]);
                            }
                          )
                        );
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Friend Search...',
                    contentPadding: EdgeInsets.all(12.0),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(24.0)),
                  color: Color(0x55ffffff),
                ),
              ),

              SizedBox(height: 16),

              //friend list
              ListView.builder(
                itemCount: ids.length,
                itemBuilder: (BuildContext context, int index) {
                  String user = ids[index];
                  String name = User.currentUser.getFriendName(user);

                  if (name == null)
                  {
                    name = searchNames[index];
                  }
                  return friendButton('images/headShot1.jpeg', name, "N/A", user, "N/A");
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
  Widget friendButton(String imageName, String name, String subText, String id, String status) {
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
                  builder: (context)
                  {
                    if (User.currentUser.chats.where((chat) =>
                      chat.getOtherUser() == id).length == 0)
                    {
                      User.currentUser.addChat(id);
                    }
                    return ChatScreen(
                      User.currentUser.chats.firstWhere((chat) =>
                        chat.getOtherUser() == id
                      ).chatId
                    );
                  },
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
                  
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                        
                            image: AssetImage(imageName),
                            fit: BoxFit.cover,
                          
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),

                      ), 
                    //),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendProfile(name, imageName, status, id),
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
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Montserrat'
                      ),
                    ),
                    Text(
                      subText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
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

