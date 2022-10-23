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
    var courseJSON = await rootBundle.loadString("sample_data/courses.json");
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
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Text("SKILL EDGE"),
        ),
        // centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          NavigationMenu(ind: 1),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  Text(dummyData[index].description),
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
