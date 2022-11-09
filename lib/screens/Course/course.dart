import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:skill_edge/models/chapter_model.dart';
import 'package:skill_edge/models/course_model.dart';
import 'package:skill_edge/screens/Course/components/chapter_tile.dart';
import '../Quiz/quiz_page.dart';

class Course extends StatefulWidget {

  final CourseModel course;
  const Course({super.key, required this.course});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  List<ChapterModel> chapters = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // Fetch data from cloud firestore
    final FirebaseFirestore db = FirebaseFirestore.instance;
    var querySnapshot = await db
        .collection("courses")
        .doc(widget.course.id)
        .collection("chapters")
        .get();
    final allData = querySnapshot.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    chapters = List.from(allData)
        .map<ChapterModel>((course) => ChapterModel.fromMap(course))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SKILL EDGE"),
        backgroundColor: Colors.white,
      ),
      body: chapters.length!=0 ? SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              widget.course.title,
              textScaleFactor: 1.4,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(widget.course.description),
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
                      "Field: ${widget.course.field.toUpperCase()}",
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
                      "Branch: ${widget.course.branch.toUpperCase()}",
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
                        courseName: widget.course.title,
                        courseID: widget.course.id),
                    itemCount: chapters.length,
                  )),
            ),
          ],
          
        ),
      )) : Center(child: CircularProgressIndicator(),),
    );
  }
}
