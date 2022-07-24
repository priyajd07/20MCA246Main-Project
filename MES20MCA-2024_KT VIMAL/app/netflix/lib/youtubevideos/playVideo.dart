//@dart=2.9
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class PlayVideo extends StatefulWidget {
  final String videoLink;
  final String title;
  const PlayVideo({Key key,  this.videoLink, this.title}) : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  YoutubePlayerController _controller;
  @override
  void initState() {

    _controller = YoutubePlayerController(
      // id youtube video
        initialVideoId: YoutubePlayer.convertUrlToId(
          widget.videoLink,
        ),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ));


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:YoutubePlayerBuilder(
        player:  YoutubePlayer(

        controller: _controller,
      ),
        builder: (context,player) {
          return Column(
            children: [
              Expanded(child: SizedBox()),
              Text(widget.title,style: TextStyle(
                color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18
              ),),
              SizedBox(height: 10,),
              player,
              Expanded(child: SizedBox()),
            ],
          );
        }
      ) ,
    );
  }
}
