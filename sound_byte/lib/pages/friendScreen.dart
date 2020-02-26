import 'package:flutter/material.dart';
import 'package:sound_byte/pages/chatScreen.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:sound_byte/pages/userProfile.dart';
import 'package:sound_byte/pages/friendProfile.dart';

//screen to see all recent chats with friends and access to contact list
class FriendScreen extends StatefulWidget {
 @override
  FriendScreen({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key); 

  _FriendScreenState createState() => _FriendScreenState();
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
}

class _FriendScreenState extends State<FriendScreen> {
  TextEditingController nameTextController;

  @override
  void initState() {
    nameTextController = new TextEditingController();
    super.initState();
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
          FlatButton(child: Text('Profile',
            style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () 
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => 
                UserProfilePage(
                   auth: widget.auth,
                   userId: widget.userId,
                   logoutCallback: widget.logoutCallback,
                )),
            );
          }
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
            children: <Widget>[
              //friend search bar bar
              Container(
                child: TextField(
                  onChanged: (String input) {
                    //TODO: update the list based on input
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
              //TODO: add real data
              friendButton(
                  'images/headShot1.jpeg', "John", "last online: 2 hours ago", 1, "Software Engineer"),
              friendButton(
                  'images/headShot2.jpeg', "David", "Online", 2 ,"Soccer Player"),
              friendButton(
                  'images/headShot3.jpeg', "Xavier", "last online: 3 minutes ago", 3, "Teacher"),
              friendButton(
                  'images/headShot4.jpeg', "Sarah", "last online: 4 seconds ago", 4, "Nurse"),
              friendButton(
                  'images/headShot5.png', "Jennifer", "Online", 5, "Lawyer")
            ],
          ),
        ),
      ),
    );
  }

  //creates a button displaying all the information about a friend
  Widget friendButton(String imageName, String name, String subText, int id, String status) {
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
                  builder: (context) => ChatScreen(),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //image of friend
                //TODO: add default image if none is set
                
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
                          builder: (context) => FriendProfile(name, imageName, id, status),
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

