import "package:flutter/material.dart";
import 'package:skill_edge/models/chapter_model.dart';
import 'package:skill_edge/models/course_model.dart';
import 'package:skill_edge/screens/Course/components/chapter_tile.dart';

import '../Quiz/quiz_page.dart';

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
            const SizedBox(height: 20),
            Text(
              course.title,
              textScaleFactor: 1.4,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(course.description),
            const SizedBox(height: 10),
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemBuilder: (context, index) => ChapterTile(
                        ind: index,
                        chapter: chapters[index],
                        courseName: course.title),
                    itemCount: chapters.length,
                  )),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const QuizPage();
              }));
            }, child: Text('Give Quiz'))
          ],
          
        ),
      )),
    );
  }
}
