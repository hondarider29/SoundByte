import 'package:flutter/material.dart';
import 'package:sound_byte/pages/friendScreen.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserProfilePage extends StatefulWidget {
  @override
  // UserProfilePage({this.auth, this.userId, this.logoutCallback});
  UserProfilePage({Key key, this.auth, this.userId,this.logoutCallback})
    : super(key: key);

  _UserProfilePageState createState() => _UserProfilePageState();
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

}

class _UserProfilePageState extends State<UserProfilePage>
{
  final String _fullName = "David Sann";
  final String _status = "Software Engineer";
  TextEditingController nameTextController;

   
  signOut1() {
      widget.auth.getCurrentUser().then((user) {
        signOut();
      });
  }


 Future<String> inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
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
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        title: Text("Profile"),
        actions: <Widget>[
          FlatButton(child: Text('Logout',
            style: new TextStyle(fontSize: 17.0, color: Colors.white)),
          onPressed: signOut1()
          )
        ],
        //back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FriendScreen()),
            );
          },
        ), // IconButton
      ), // AppBar
      body: Stack(
        children: <Widget> [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 30),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  Divider(color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  _buildBio(),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(color: Colors.black),
                  Text("Favorite Songs"),
                  _buildFavSongs(),
                ],
              ),
            ),
          ),
        ],

      //list of all contacts and search
      //IDEA: maybe turn into a stream 
      )
    );
  }


  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage( 'images/headShot1.jpeg'),
            fit: BoxFit.cover,
          ), // Decoration Image
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.black,
            width: 5.0,
          ), // Border.all
        ), // BoxDecoration
      ), // Container
    ); // Center
  }
  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle (
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return Text (
    _fullName,
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
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildBio() {
    return Text (
      "Hello, my name is " + _fullName + " and I love music!"
    );
  }

  Widget _buildFavSongs() {
    return Text (
      "Star Spangled Banner"
    );
  }
 

}
//problem, cant pass a logoutcallback to user and cant go back
  

  // decoration: BoxDecoration(
        
  //       color: Theme.of(context).scaffoldBackgroundColor,
  //       borderRadius: BorderRadius.circular(4.0),
    
  //     ),