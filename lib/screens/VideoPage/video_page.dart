import "package:flutter/material.dart";
import 'package:skill_edge/components/video_player.dart';
import 'package:skill_edge/models/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  final VideoModel video;
  const VideoPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SKILL EDGE"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 10,
            ),
            Container(
                constraints: BoxConstraints(maxHeight: 300),
                child: MyVideoPlayer(
                    video: VideoPlayerController.network(video.url))
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              video.title,
              textScaleFactor: 1.4,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(video.description)
          ]),
        ),
      ),
    );
  }
}
