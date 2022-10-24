import "package:flutter/material.dart";
import 'package:skill_edge/models/chapter_model.dart';
import 'package:skill_edge/models/course_model.dart';
import 'package:skill_edge/screens/Course/course.dart';

class CourseTile extends StatelessWidget {
  final CourseModel course;
  const CourseTile({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 130, maxHeight: 50),
      // color: Colors.red,
      child: InkWell(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Course(course: course);
        })),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(course.image),
              const SizedBox(
                height: 4,
              ),
              Text(
                course.title,
                overflow: TextOverflow.fade,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                course.description,
                overflow: TextOverflow.fade,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
