import "package:flutter/material.dart";
import 'package:skill_edge/models/chapter_model.dart';
import 'package:skill_edge/models/course_model.dart';
import 'package:skill_edge/screens/Course/components/chapter_tile.dart';

class Course extends StatelessWidget {
  final CourseModel course;
  const Course({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    List<ChapterModel> chapters = List.from(course.chapters)
        .map<ChapterModel>((chapter) => ChapterModel.fromMap(chapter))
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
            SizedBox(height: 20),
            Text(
              course.title,
              textScaleFactor: 1.4,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(course.description),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueGrey),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Field: ${course.field.toUpperCase()}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueGrey),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Branch: ${course.branch.toUpperCase()}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
                height: 300,
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      ChapterTile(ind: index, chapter: chapters[index]),
                  itemCount: chapters.length,
                ))
          ],
        ),
      )),
    );
  }
}
