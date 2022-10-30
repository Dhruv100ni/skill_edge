import 'package:flutter/material.dart';
import 'package:skill_edge/screens/Login_SignUp/login.dart';
import 'package:skill_edge/screens/Articles/articles.dart';
import 'package:skill_edge/screens/Courses/courses.dart';
import 'package:skill_edge/screens/Profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SKill Edge',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.lightBlue,
      ),
      routes: {
        "/": (context) => Login(),
        "/articles": (context) => const Articles(),
        "/courses": (context) => const Courses(),
        "/profile": (context) => const Profile(),
      },
    );
  }
}
