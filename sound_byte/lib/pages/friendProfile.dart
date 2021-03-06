import 'package:flutter/material.dart';
import 'package:sound_byte/pages/chatScreen.dart';
import 'package:sound_byte/pages/friendScreen.dart';
import 'package:sound_byte/pages/musicList.dart';
import 'package:sound_byte/pages/userProfile.dart';

class FriendProfile extends StatefulWidget {

  FriendProfile(this._fullName, this._image, this._status);

  final String _fullName;
  final String _status;
  final String _image;

  @override
  _FriendProfileState createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  final String _followers = "173";

  final String _playlists = "24";

  final String _views = "450";

  final String _bio = "Hello, I am David and love music!";

  Widget _buildProfileImage(Size screenSize) {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage( widget._image),
            fit: BoxFit.cover,
        ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 5.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle (
      fontFamily: 'Pop',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return Text (
    widget._fullName,
    style: _nameTextStyle,
    );
  }

   Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        widget._status,
        style: TextStyle(
          fontFamily: 'Pop',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildBio() {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Pop',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: Colors.black,
      fontSize: 16.0,
    );

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget showBackground(Size screenSize) {
    return Container(
          height: screenSize.height,
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.fill
        )
      ),
    );
  }

  Widget buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/instr.jpg'),
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("PlayLists", _playlists),
          _buildStatItem("Views", _views),
          
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Pop',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  int _pageT = 1;

  Widget nav (BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: BottomNavigationBar(
        currentIndex: _pageT,
        onTap: (int index) {
          test(index, context);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            title: Text('Player',
             style: TextStyle(
              fontFamily: 'Pop'
            ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home',
             style: TextStyle(
              fontFamily: 'Pop'
            ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag_faces),
            title: Text('Profile',
            style: TextStyle(
              fontFamily: 'Pop'
              ),
            ),
          )
        ],
       )
      );
  }

  void test (int index, BuildContext context) {
    if (index == 0) {
       Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicList(),
                ),
       );
    }
    else if (index == 1) {
      Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FriendScreen(),
            ),
       );
    }
    else if (index == 2) {
      Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(),
            ),
       );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(child: Text('Chat',
            key: Key("startChat"),
            style: new TextStyle(fontSize: 17.0, 
            color: Colors.white,
            fontFamily: 'Pop'
              )
            ),
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen("chatID"),
                ),
              );
            }
          )
        ],
      ),
      //backgroundColor: Color.fromRGBO(0, 0, 140, 0),
      body: Stack(
        children: <Widget>[
          //showBackground(screenSize),
          buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(screenSize),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildBio(),
                  SizedBox(height: screenSize.height / 5.6),
                  //_buildSeparator(screenSize),
                  nav(context)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
 
 
