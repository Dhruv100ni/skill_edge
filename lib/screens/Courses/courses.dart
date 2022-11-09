import "package:provider/provider.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:skill_edge/models/course_model.dart';
import 'package:skill_edge/screens/Courses/course_tile.dart';

class Courses extends StatefulWidget {
  final branch;
  final field;
  Courses({super.key, required this.branch, required this.field});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<CourseModel> courseData = [];
  List<CourseModel> recomendedData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // Fetch data from cloud firestore
    final FirebaseFirestore db = FirebaseFirestore.instance;
    var querySnapshot = await db.collection("courses").get();
    final allData = querySnapshot.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    // print(allData);
    // await Future.delayed(const Duration(seconds: 2));
    // var courseJSON =
    //     await rootBundle.loadString("assets/sample_data/courses.json");
    // var decodedData = jsonDecode(courseJSON);
    // //print(decodedData);
    courseData = List.from(allData)
        .map<CourseModel>((course) => CourseModel.fromMap(course))
        .toList();
    var recomSnapshot = await db
        .collection("courses")
        .where("branch", isEqualTo: widget.branch)
        .where("field", isEqualTo: widget.field)
        .get();
    final recomData = recomSnapshot.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    recomendedData = List.from(recomData)
        .map<CourseModel>(((course) => CourseModel.fromMap(course)))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // List<CourseModel> dummyData = courseData;
    // if (courseData.isNotEmpty) {
    //   dummyData = List.generate(10, (index) => courseData[0]);
    // }
    return Scaffold(
      body: recomendedData.length!=0 ? SingleChildScrollView(
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
                    CourseTile(course: recomendedData[index]),
                itemCount: recomendedData.length,
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
                    CourseTile(course: courseData[index]),
                itemCount: courseData.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  width: 12,
                ),
              ),
            )
          ]),
        ),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }
}
