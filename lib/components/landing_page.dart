import 'package:flutter/material.dart';
import 'package:skill_edge/screens/Courses/courses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skill_edge/screens/InterviewQuestions/interview_questions.dart';
import '../screens/Articles/articles.dart';
import '../screens/Homepage/home.dart';
import '../screens/Profile/edit_profile.dart';
import "package:provider/provider.dart";
import 'package:skill_edge/providers/user_provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void fillState() async {
    if (auth.currentUser != null) {
      String uid = auth.currentUser!.uid;
      final docRef = db.collection("users").doc(uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          context.read<CurrentUser>().compLogin(
              data["username"], data["email"], data["branch"], data["field"]);
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    fillState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("SKILL EDGE"),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25)),
                child: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: 'Home'),
                    Tab(text: 'Courses'),
                    Tab(text: 'Articles'),
                    Tab(text: 'Interview Questions'),
                    Tab(text: 'Profile'),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: [
                  Home(
                    tabController: _tabController,
                  ),
                  Courses(
                      branch: context.watch<CurrentUser>().branch,
                      field: context.watch<CurrentUser>().field),
                  const Articles(),
                  const InterviewQuestions(),
                  EditProfilePage(
                    username: context.watch<CurrentUser>().username,
                    email: context.watch<CurrentUser>().email,
                    branch: context.watch<CurrentUser>().branch,
                    field: context.watch<CurrentUser>().field,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
