import 'package:flutter/material.dart';
import 'package:sound_byte/pages/chatScreen.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:sound_byte/pages/userProfile.dart';
import 'package:sound_byte/pages/friendProfile.dart';
import 'package:sound_byte/pages/friendScreen.dart';

class FriendProfile extends StatelessWidget {

  FriendProfile(this._fullName, this._image, this._id, this._status);

  String _image;
  String _fullName;
  String _id;
  String _status;
  @override
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        title: Text("Profile"),
       
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
                  _buildBio(_id),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(color: Colors.black),
                  Text("Favorite Songs"),
                  _buildFavSongs(_id),
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
            image: AssetImage( _image),
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

  Widget _buildBio(String id) {
    return Text (
      
      "Hello, my name is " + _fullName + " and I love music!"
    
    );
  }

  Widget _buildFavSongs(String id) {
    String va;
    if(id == 1){
      va = "Star Spangled Banner";
    }
    else if(id == 2){
      va = "Umbrella";
    }
     else if(id == 2){
      va = "Fur Elise";
    }
    else {
      va = "We are the Champions";
    }
    return Text (
      va
    );
  }

}
 
 
