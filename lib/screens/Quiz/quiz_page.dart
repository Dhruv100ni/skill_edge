import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:skill_edge/components/landing_page.dart';
import 'package:skill_edge/components/quiz_question.dart';

import '../../models/chapter_model.dart';
import '../../models/quiz_model.dart';

import 'package:provider/provider.dart';
import 'package:skill_edge/providers/quiz_provider.dart';

class QuizPage extends StatefulWidget {
  final String courseID;
  final ChapterModel chapter;
  final int quizDuration;
  final String quizTitle;
  const QuizPage(
      {super.key,
      required this.courseID,
      required this.chapter,
      required this.quizDuration,
      required this.quizTitle});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late AnimationController progressController;
  late CountdownTimerController timerController;
  late TabController _tabController;
  List<QuizModel> questions = [];

  Map<int, String> answers = HashMap();

  void setOption(int qid, String option) {
    answers.update(qid, (value) => option);
  }

  // ENDING TIME OF QUIZ YYYY-MM-DD HH:MM:SS
  DateTime now = DateTime.now();
  late int timeLeft;
  late int endTime;

  @override
  void initState() {
    var time = now
        .add(Duration(minutes: widget.quizDuration))
        .toString(); //"2022-11-07 11:40:00";
    timeLeft = DateTime.parse(time).millisecondsSinceEpoch -
        DateTime.now().millisecondsSinceEpoch;
    endTime = DateTime.parse(time).millisecondsSinceEpoch;
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: timeLeft))
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          if (status == AnimationStatus.completed) {}
        });
      })
      ..addListener(() {
        setState(() {});
      });
    progressController.forward();

    timerController =
        CountdownTimerController(endTime: endTime, onEnd: timerOnEnd);
    loadData();

    super.initState();
  }

  void loadData() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    var quizData = await db
        .collection("courses")
        .doc(widget.courseID)
        .collection("chapters")
        .doc(widget.chapter.id)
        .collection("Questions")
        .get();

    final quiz = quizData.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    questions = List.from(quiz)
        .map<QuizModel>((quiz) => QuizModel.fromMap(quiz))
        .toList();

    _tabController = TabController(length: questions.length, vsync: this);
    setState(() {});
  }

  void timerOnEnd() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Quiz is over!'),
            content: Text('Thanks for giving the quiz :)'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LandingPage()),
                        ((route) => false));
                  },
                  child: Text('Go to homepage')),
              TextButton(onPressed: () {}, child: Text('Check your result')),
            ],
          );
        });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LandingPage();
    }));
  }

  @override
  void dispose() {
    progressController.dispose();
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: questions.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.quizTitle,
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LinearProgressIndicator(
                      value: progressController.value,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Time Left: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        CountdownTimer(
                          controller: timerController,
                          endTime: endTime,
                          onEnd: timerOnEnd,
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25)),
                      child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          // tabs: const [
                          //   Tab(text: 'Home'),
                          //   Tab(text: 'Courses'),
                          //   Tab(text: 'Articles'),
                          //   Tab(text: 'Profile')
                          // ],
                          tabs: [
                            for (int i = 1; i < questions.length + 1; i++)
                              Tab(text: i.toString())
                          ]),
                    ),
                    Expanded(
                        child: TabBarView(
                      controller: _tabController,
                      children: [
                        for (int i = 0; i < questions.length; i++)
                          Question(
                              question: questions[i].question,
                              A: questions[i].A,
                              B: questions[i].B,
                              C: questions[i].C,
                              D: questions[i].D,
                              id: i),
                      ],
                    )),
                    // for(int i=0; i<questions.length; i++)
                    //Question(question: questions[i].question, A: questions[i].A, B: questions[i].B, C: questions[i].C, D: questions[i].D, ans: questions[i].ans,),

                    // Question(question: questions[0].question, A: questions[0].A, B: questions[0].B, C: questions[0].C, D: questions[0].D, ans: questions[0].ans,),
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          onPressed: () {
                            _tabController
                                .animateTo((_tabController.index - 1) % 2);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.arrow_left_outlined),
                              Text('Previous Question')
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          onPressed: () {
                            _tabController
                                .animateTo((_tabController.index + 1) % 2);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.arrow_right_outlined),
                              Text('Next Question')
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () async {
                          int score = 0;
                          for (int i = 0; i < questions.length; i++)
                            if (context.read<QuizProvider>().getValue(i) ==
                                questions[i].ans) score++;

                          await FirebaseFirestore.instance
                              .collection("courses")
                              .doc(widget.courseID)
                              .collection("chapters")
                              .doc(widget.chapter.id)
                              .collection("userScore")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .set({"score": score});

                          context.read<QuizProvider>().clearMap();
                          await showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 3), (){
                                Navigator.pop(context);
                              });
                              return AlertDialog(
                                title: Text('Quiz is over!'),
                                content: Text('Thanks for giving the quiz :)'),
                              );
                            }
                          );
                          await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LandingPage()), (route) => false);
                        },
                        child: Text(
                          'Submit Quiz',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
      ),
    );
  }
}
