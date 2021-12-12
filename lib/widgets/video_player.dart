import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';


class VideoPlayerPost extends StatefulWidget {
  const VideoPlayerPost({ Key? key }) : super(key: key);

  @override
  _VideoPlayerPostState createState() => _VideoPlayerPostState();
}

class _VideoPlayerPostState extends State<VideoPlayerPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BetterPlayer.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      betterPlayerConfiguration: BetterPlayerConfiguration(
        aspectRatio: 1,
        looping: true,
        autoPlay: true,
        fit: BoxFit.contain,
      ),
      ),
    );
  }
}