import 'package:flutter/material.dart';
import 'package:sound_byte/pages/friendScreen.dart';

class UserProfilePage extends StatelessWidget {


  final String _fullName = "David Sann";
  final String _status = "Software Engineer";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        title: Text('User Info'),
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
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
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
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage( 'images/headshot1.jpeg'),
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
    "Michael Michaels",
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
}