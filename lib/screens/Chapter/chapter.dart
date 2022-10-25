import "package:flutter/material.dart";
import 'package:skill_edge/models/chapter_model.dart';
import 'package:skill_edge/models/video_model.dart';

class Chapter extends StatelessWidget {
  final int ind;
  final ChapterModel chapter;
  final String courseName;
  const Chapter(
      {super.key,
      required this.ind,
      required this.chapter,
      required this.courseName});

  @override
  Widget build(BuildContext context) {
    List<VideoModel> videos = List.from(chapter.videos)
        .map<VideoModel>((video) => VideoModel.fromMap(video))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("SKILL EDGE"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "$courseName > ${chapter.title}",
              textScaleFactor: 1.4,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Video Lectures",
              style: TextStyle(fontSize: 15, color: Colors.blueGrey),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                constraints: BoxConstraints(maxHeight: 1000),
                child: ListView.builder(
                  itemBuilder: ((context, index) => Card(
                        child: ListTile(
                            title: Text(videos[ind].title),
                            trailing: const Text("Start")),
                      )),
                  itemCount: videos.length,
                ))
          ],
        ),
      )),
    );
  }
}
