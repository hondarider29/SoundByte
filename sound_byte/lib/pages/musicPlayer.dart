import 'package:flutter/material.dart';
import 'package:sound_byte/pages/musicList.dart';

class MusicPlayer extends StatelessWidget {
  final title;
  final artist;
  final image;

  MusicPlayer(this.title, this.artist, this.image);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;  
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildMain(screenSize, title, artist, image, context)
        ],
      ),
    );
    }
}

Widget buildMain (Size screenSize, title, artist, image, BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blue,
      body: Column(
        children: <Widget>[
          Container(
            height: 420.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.withOpacity(0.4), Colors.blue],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 52.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                    MaterialPageRoute(
                                      builder: (context) => MusicList(),
                                    ),
                                );
                              },
                            ),
                            // child: Icon(
                            //   Icons.arrow_drop_down,
                            //   color: Colors.white,
                            // ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'PLAYLIST',
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    color: Colors.white.withOpacity(0.6)),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.playlist_add,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Spacer(),
                      Text(title,
                          style: TextStyle(
                            fontFamily: "Laq",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32.0),
                              ),
                              
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        artist,
                        style: TextStyle(
                          fontFamily: "Laq",
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 18.0),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 42.0),
          Slider(
            onChanged: (double value) {},
            value: 0.2,
            activeColor: Colors.pink,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '2:10',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Text('-03:56',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)))
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.fast_rewind,
                color: Colors.white54,
                size: 42.0,
              ),
              SizedBox(width: 32.0),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Icon(
                      Icons.play_arrow,
                      size: 58.0,
                      color: Colors.white,
                    ),
                  )),
              SizedBox(width: 32.0),
              Icon(
                Icons.fast_forward,
                color: Colors.white54,
                size: 42.0,
              )
            ],
          ),
          Spacer(),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.bookmark_border,
                color:  Colors.pink,
              ),
              Icon(
                Icons.shuffle,
                color: Colors.pink,
              ),
              Icon(
                Icons.repeat,
                color: Colors.pink,
              ),
            ],
          ),
          SizedBox(height: 23.0),
        ],
      ),
    );
  }


  