import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:skill_edge/components/landing_page.dart';
import 'package:skill_edge/components/quiz_question.dart';

import '../../models/chapter_model.dart';
import '../../models/quiz_model.dart';

class QuizData extends StatefulWidget {
  final String courseID;
  final ChapterModel chapter;
  final int quizDuration;
  final String quizTitle;
  const QuizData({super.key, required this.courseID, required this.chapter, required this.quizDuration, required this.quizTitle});

  @override
  State<QuizData> createState() => _QuizDataState();
}

class _QuizDataState extends State<QuizData> with TickerProviderStateMixin {

  late final CollectionReference;
  
  @override
  void initState(){
    CollectionReference = FirebaseFirestore.instance.collection("courses").doc(widget.courseID).collection("chapters").doc(widget.chapter.id).collection("Questions");
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("courses").doc(widget.courseID).collection("chapters").doc(widget.chapter.id).collection("Questions").snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot){
          // var items = snapshot.data?.docs ?? [];

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var temp = snapshot.data!.docs[index].data();
              print(temp);
              return ListTile(
                title: Text('A'),
              );
            },
          );
        },
      ),
    );
  }
}
