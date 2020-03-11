
import 'package:flutter/material.dart';
import 'package:sound_byte/pages/musicList.dart';

class MusicPlayer extends StatefulWidget {
  MusicPlayer(this.title, this.artist, this.image);
   @override
  _MusicPlayerState createState() => _MusicPlayerState(this.title, this.artist, this.image);

  final title;
  final artist;
  final image;
}

class _MusicPlayerState extends State<MusicPlayer>{

  final title;
  final artist;
  final image;

  _MusicPlayerState(this.title, this.artist, this.image);
  Color _iconColorBM = Colors.pink;
  Color _iconColorRP = Colors.pink;
  Color _iconColorSH = Colors.pink;
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



Widget buildMain (Size screenSize, title, artist, image, BuildContext context) {
  double value1 = 0.0;
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
                                      fontFamily: "Pop",
                                      color: Colors.white.withOpacity(0.6)),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.playlist_add),
                                color: Colors.white, 
                                onPressed: () {},
                                iconSize: 30,
                      ),
                          ],
                        ),
                        Spacer(),
                        Text(title,
                            style: TextStyle(
                              fontFamily: "Pop",
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
                            fontFamily: "Pop",
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
              value: value1,
              activeColor: Colors.pink,
              label: "$value1",
              min: 0.0,
              max: 10.0,
              onChanged: (double newVal) {
                // = newVal;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '0:00',
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
                IconButton(
                        icon: Icon(Icons.fast_rewind),
                          color: Colors.white, 
                          onPressed: () {},
                          iconSize: 40,
                          
                      ),
                SizedBox(width: 32.0),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                     child: 
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                          color: Colors.white, 
                          onPressed: () {},
                          iconSize: 40,
                          
                      ),
                    )),
                SizedBox(width: 32.0),
                IconButton(
                  icon: Icon(Icons.fast_forward),
                  color: Colors.white, 
                  onPressed: () {},
                  iconSize: 40,
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              height: 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.bookmark),
                    color: _iconColorBM,
                    onPressed: () {
                      setState(() {
                       if(_iconColorBM == Colors.white){
                            _iconColorBM = Colors.pink;
                          }
                          else{
                            _iconColorBM = Colors.white;
                          }
                       });
                    },
                ),
              IconButton(
                      icon: Icon(Icons.shuffle),
                      color: _iconColorSH,
                      onPressed: () {
                            setState(() {
                              if(_iconColorSH == Colors.white){
                            _iconColorSH = Colors.pink;
                          }
                          else{
                            _iconColorSH = Colors.white;
                          }
                       });    
                      },
              ),
              IconButton(
                     icon: Icon(Icons.repeat),
                    color: _iconColorRP,
                      onPressed: () {
                        setState(() {
                          if(_iconColorRP == Colors.white){
                            _iconColorRP = Colors.pink;
                          }
                          else{
                            _iconColorRP = Colors.white;
                          }
                        
                       });     
                      },
              ),
            ],
          ),
          SizedBox(height: 23.0),
        ],
      ),
    );
  }
}