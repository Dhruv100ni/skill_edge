import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:skill_edge/components/navigation_menu.dart';
import 'package:skill_edge/models/course_model.dart';
import 'package:skill_edge/screens/Courses/course_tile.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<CourseModel> courseData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // await Future.delayed(const Duration(seconds: 2));
    var courseJSON =
        await rootBundle.loadString("assets/sample_data/courses.json");
    var decodedData = jsonDecode(courseJSON);
    //print(decodedData);
    courseData = List.from(decodedData["Courses"])
        .map<CourseModel>((course) => CourseModel.fromMap(course))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<CourseModel> dummyData = [];
    if (courseData.isNotEmpty) {
      dummyData = List.generate(10, (index) => courseData[0]);
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Recomended Courses",
            textScaleFactor: 1.2,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(maxHeight: 180),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  CourseTile(course: dummyData[index]),
              itemCount: dummyData.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "All Courses",
            textScaleFactor: 1.2,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: BoxConstraints(maxHeight: 180),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  CourseTile(course: dummyData[index]),
              itemCount: dummyData.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 12,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
