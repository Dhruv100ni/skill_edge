import "package:flutter/material.dart";
import 'package:skill_edge/models/course_model.dart';
import 'package:skill_edge/screens/Course/course.dart';

class CourseTile extends StatelessWidget {
  final CourseModel course;
  const CourseTile({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Course(course: course);
        })),
        child: Card(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                      height: 120,
                      child: course.image == ""
                          ? Image.asset("assets/images/logo.jpg")
                          : Image.network(course.image)),
                ),
                  Text(
                    course.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    course.description,
                    overflow: TextOverflow.ellipsis,
                  )
              ]),
            ),
          ),
        ),
      );
  }
}
