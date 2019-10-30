import 'package:flutter/material.dart';
import 'package:sound_byte/chatScreen.dart';

//screen to see all recent chats with friends and access to contact list
class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
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
        //back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            //Navigator.pop(context);
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
                  onChanged: (String input){
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
        
              //friend list
              friendButton("../images/headShot1.jpg", "John", "this is a test"),
              friendButton("../images/headShot2.jpg", "John", "this is a test"),
              friendButton("../images/headShot3.jpg", "John", "this is a test"),
              friendButton("../images/headShot4.jpg", "John", "this is a test"),
              friendButton("../images/headShot5.jpg", "John", "this is a test"),
            ],
          ),
        ),
      ),
    );
  }

  //creates a button displaying all the information about a friend
  //TODO: clean up display of the friends
  Widget friendButton(String imageName, String name, String subText) {
    double size = 50;

    return Column(
      children: <Widget>[
        FlatButton(
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
            children: <Widget>[
              //image of friend
              //TODO: add default image if none is set
              Container(
                width: size,
                height: size,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(imageName),
                  ),
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
        SizedBox(height: 16),
      ],
    );
  }
}
