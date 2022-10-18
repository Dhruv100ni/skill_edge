import 'package:flutter/material.dart';
import 'package:skill_edge/screens/Articles/articles.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:skill_edge/screens/Welcome/welcome_screen.dart';
//import 'package:skill_edge/screens/Welcome/components/login_signup_btn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SKill Edge',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      //home: LoginAndSignupBtn(),
      // home: const WelcomeScreen(),
      routes: {
        "/": (context) => const WelcomeScreen(),
        "/articles": (context) => const Articles(),
      },
    );
  }
}
