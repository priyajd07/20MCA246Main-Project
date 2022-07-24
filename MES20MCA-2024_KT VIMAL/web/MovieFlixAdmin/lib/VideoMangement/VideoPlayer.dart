import 'package:flutter/cupertino.dart';

import '../flutter_flow/flutter_flow_video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String url;
  const VideoPlayer({Key key, this.url}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(child: // Generated code for this VideoPlayer Widget...
    FlutterFlowVideoPlayer(
      path:
      widget.url,
      videoType: VideoType.network,
      autoPlay: true,
      looping: false,
      showControls: true,
      allowFullScreen: true,
      allowPlaybackSpeedMenu: false,

    )
      ,);
  }
}
