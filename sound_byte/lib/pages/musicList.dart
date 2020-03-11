import 'package:flutter/material.dart';
import 'package:sound_byte/pages/friendScreen.dart';
import 'package:sound_byte/pages/userProfile.dart';

import 'Songs.dart';

class MusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;  
    return Scaffold(
      body: Stack(
        children: <Widget>[
          showBackground(screenSize),
          buildMain(screenSize),
          nav(context)
        ],
      ),
    );
    }
}

var rex = 'https://i2.wp.com/cornellsun.com/wp-content/uploads/2019/10/Pg-6-7-Arts-Pony-Alasdair-Mclellan-for-Rex-Orange-County.jpg?w=1600';
var martinGarrix =
    'https://upload.wikimedia.org/wikipedia/en/thumb/5/5a/Wearethechampions.jpg/220px-Wearethechampions.jpg';
var rosieLowe =
    'https://http2.mlstatic.com/eminem-the-eminem-show-cd-D_NQ_NP_725094-MLM29175119619_012019-F.jpg';
var rad = 'https://i.pinimg.com/originals/86/7c/5f/867c5fcbaac0e41e10bd2de274d8233c.jpg';

  Widget buildMain(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            SearchBar(),
            SizedBox(height: 32.0),
            Text(
              'Your Songs',
              style: TextStyle(
                fontFamily: "Pop",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 38.0),
                  
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 16.0,
            ),
            SongItem('Always', 'Orange Rex County', rex),
            SongItem('We Are The Champions', 'Queen', martinGarrix),
            SongItem('Rap', 'Eminem', rosieLowe),
            SongItem('Song', 'Artist', rad),
            SongItem('Another Song', 'Maker', rad),
          ],
        )
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

  int _pageT = 0;
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
            key: Key("playerPage"),
             style: TextStyle(
              fontFamily: 'Pop'
            ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home',
            key: Key("homePage"),
             style: TextStyle(
              fontFamily: 'Pop'
            ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag_faces),
            title: Text('Profile',
            key: Key("profilePage"),
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
    if (index == 1) {
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

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue[200],
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 8.0,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextField(
              key: Key("musicSearch"),
              style: TextStyle(
                fontFamily: "Pop",
              ),
              decoration: InputDecoration(
                  hintText: 'Search music...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
              )
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }
}


/*
class ItemCard extends StatelessWidget {
  final image;
  final title;
  ItemCard(this.image, this.title);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 120.0,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: 140.0,
                      width: double.infinity,
                    )),
                Positioned(
                  right: 16.0,
                  top: 16.0,
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.white.withOpacity(0.6),
                    size: 24.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}

*/
