import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_byte/pages/musicList.dart';
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
  User searchedUser;

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
                  onChanged: (String input) {
                    Firestore.instance.collection('Users').where("name", isEqualTo: input).getDocuments().then((querySnapshot)
                      => searchedUser = new User.full(querySnapshot.documents[0].documentID,
                                                      querySnapshot.documents[0].data['name'],
                                                      querySnapshot.documents[0].data['email'],
                                                      querySnapshot.documents[0].data['friends'],
                                                      querySnapshot.documents[0].data['chats']));
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
                itemCount: User.currentUser == new User.nullUser() ? 0 : User.currentUser.friends.length,
                itemBuilder: (BuildContext context, int index) {
                  String friend = User.currentUser.friends[index];
                  return friendButton('images/headShot1.jpeg', User.currentUser.getFriendName(friend), "N/A", friend, "N/A");
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
                //TODO: add name to navigator to allow chat screen to load correct conversation
                MaterialPageRoute(
                 // builder: (context) => ChatScreen(
                 //   "xuAoPiLJgAa7LZc0Y0b7"
                //  ),
                  //only testing the music player
                  builder: (context) => MusicList(),
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
                          builder: (context) => FriendProfile(name, imageName, status),
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

