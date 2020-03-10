import 'package:flutter/material.dart';

import 'Songs.dart';

class MusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;  
    return Scaffold(
      body: Stack(
        children: <Widget>[
          showBackground(screenSize),
          buildMain(screenSize)
        ],
      ),
    );
    }
}

var flume = 'https://i.scdn.co/image/8d84f7b313ca9bafcefcf37d4e59a8265c7d3fff';
var martinGarrix =
    'https://c1.staticflickr.com/2/1841/44200429922_d0cbbf22ba_b.jpg';
var rosieLowe =
    'https://i.scdn.co/image/db8382f6c33134111a26d4bf5a482a1caa5f151c';

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
            )
            ,
            SizedBox(
              height: 16.0,
            ),
            SongItem('Edition', 'Orange Rex County', martinGarrix),
            SongItem('We Are The Champions', 'Queen', flume),
            SongItem('Rap', 'Rapper', rosieLowe),
            SongItem('Song', 'Artist', martinGarrix),
            SongItem('Another Song', 'Maker', martinGarrix),
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


