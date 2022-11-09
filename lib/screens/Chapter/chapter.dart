import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:skill_edge/components/loadQuizData.dart';
import 'package:skill_edge/models/chapter_model.dart';
import 'package:skill_edge/models/video_model.dart';
import 'package:skill_edge/screens/VideoPage/video_page.dart';

import '../Quiz/quiz_page.dart';

class Chapter extends StatefulWidget {
  final int ind;
  final ChapterModel chapter;
  final String courseName;
  final String courseID;
  const Chapter(
      {super.key,
      required this.ind,
      required this.chapter,
      required this.courseName,
      required this.courseID});

  @override
  State<Chapter> createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  List<VideoModel> videos = [];
  String quizTitle = "";
  int quizDuration = 0;
  int score = -1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // Fetch data from cloud firestore
    final FirebaseFirestore db = FirebaseFirestore.instance;

    var docRef = await db
        .collection("courses")
        .doc(widget.courseID)
        .collection("chapters")
        .doc(widget.chapter.id);

    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        quizDuration = data["quizDuration"];
        quizTitle = data["quizTitle"];
      },
      onError: (e) => print("Error getting document: $e"),
    );

    var videosData = await db
        .collection("courses")
        .doc(widget.courseID)
        .collection("chapters")
        .doc(widget.chapter.id)
        .collection("videos")
        .get();

    final allData = videosData.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    videos = List.from(allData)
        .map<VideoModel>((course) => VideoModel.fromMap(course))
        .toList();

    var scoreData = await db
        .collection("courses")
        .doc(widget.courseID)
        .collection("chapters")
        .doc(widget.chapter.id)
        .collection("userScore")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    await scoreData.get().then(
      (DocumentSnapshot doc) {
        final temp = doc.data() as Map<String, dynamic>;
        score = temp["score"];
      },
      onError: (e) => {print("Error getting document: $e")},
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          score == -1 ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuizPage(
                        courseID: widget.courseID,
                        chapter: widget.chapter,
                        quizDuration: quizDuration,
                        quizTitle: quizTitle,
                      ))) : null;
        },
        label: score == -1 ? const Text(
          'Give Quiz',
          style: TextStyle(color: Colors.white),
        ) : Text(
          'Score: $score',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      appBar: AppBar(
        title: const Text("SKILL EDGE"),
        backgroundColor: Colors.white,
      ),
      body: videos.length!=0 ? SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "${widget.courseName} > ${widget.chapter.title}",
              textScaleFactor: 1.4,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Video Lectures",
              style: TextStyle(fontSize: 15, color: Colors.blueGrey),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                constraints: BoxConstraints(maxHeight: 1000),
                child: ListView.builder(
                  itemBuilder: ((context, index) => Card(
                        child: ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VideoPage(video: videos[index]))),
                            title: Text(videos[widget.ind].title),
                            trailing: const Text("Start")),
                      )),
                  itemCount: videos.length,
                )),
          ],
        ),
      )) : Center(child: CircularProgressIndicator(),),
    );
  }
}
