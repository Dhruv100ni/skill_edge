import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:skill_edge/components/navigation_menu.dart';
import 'package:skill_edge/models/course_model.dart';

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
    await Future.delayed(const Duration(seconds: 2));
    var courseJSON = await rootBundle.loadString("assets/sample_data/courses.json");
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
      dummyData = List.generate(30, (index) => courseData[0]);
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => Text(dummyData[index].description),
            itemCount: dummyData.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              width: 12,
            ),
          ),
        )
      ]),
    );
  }
}
