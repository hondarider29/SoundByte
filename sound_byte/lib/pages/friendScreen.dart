import 'package:flutter/material.dart';
import 'package:sound_byte/pages/chatScreen.dart';
import 'package:sound_byte/services/authentication.dart';
import 'login_signup_page.dart';

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
        actions: <Widget>[
          FlatButton(child: Text('Logout',
            style: new TextStyle(fontSize: 17.0, color: Colors.white)),
          onPressed: signOut
          )
        ],
        // back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginSignupPage()),
            );
          },
        ),
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
                  'images/headShot1.jpeg', "John", "this is a test", "0yXlaPkPRdwCItEQF8Ix"),
            ],
          ),
        ),
      ),
    );
  }

  //creates a button displaying all the information about a friend
  Widget friendButton(String imageName, String name, String subText, String friendID) {
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
                  builder: (context) => ChatScreen(
                    friendID: friendID
                  ),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //image of friend
                //TODO: add default image if none is set
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    image: DecorationImage(
                        fit: BoxFit.fitHeight, image: AssetImage(imageName)),
                  ),
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
                      ),
                    ),
                    Text(
                      subText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
