import 'package:flutter/material.dart';

class FriendProfile extends StatelessWidget {

  FriendProfile(this._fullName, this._image, this._status);

  final String _fullName;
  final String _status;
  final String _image;

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
            image: AssetImage( _image),
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
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
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
      height: screenSize.height / 2.6,
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
      fontFamily: 'Roboto',
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


  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                  _buildSeparator(screenSize),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}
 
 
