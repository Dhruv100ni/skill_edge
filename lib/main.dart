import 'package:flutter/material.dart';
import 'package:skill_edge/screens/Articles/articles.dart';
import 'package:skill_edge/screens/Courses/courses.dart';
import 'package:skill_edge/screens/Welcome/welcome_screen.dart';

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
        "/": (context) => const WelcomeScreen(),
        "/articles": (context) => const Articles(),
        "/courses": (context) => const Courses()
      },
    );
  }
}
