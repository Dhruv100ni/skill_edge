import "package:flutter/material.dart";
import 'package:skill_edge/models/chapter_model.dart';
import 'package:skill_edge/screens/Chapter/chapter.dart';

class ChapterTile extends StatelessWidget {
  final int ind;
  final ChapterModel chapter;
  final String courseName;
  final String courseID;
  const ChapterTile(
      {super.key,
      required this.ind,
      required this.chapter,
      required this.courseName,
      required this.courseID});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        child: ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chapter(
                      ind: ind,
                      chapter: chapter,
                      courseName: courseName,
                      courseID: courseID))),
          title: Text("Chapter ${ind + 1}"),
          subtitle: Text(chapter.title),
          trailing: const Text("Learn"),
        ),
      ),
    );
  }
}
