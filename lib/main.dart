import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_edge/providers/user_provider.dart';
import 'package:skill_edge/screens/Articles/articles.dart';
import 'package:skill_edge/screens/Courses/courses.dart';
import 'package:skill_edge/screens/Profile/profile.dart';
import 'package:skill_edge/screens/login_signup_screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => CurrentUser())],
    child: const MyApp(),
  ));
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
        "/": (context) => const LoginScreen(),
        "/articles": (context) => const Articles(),
        "/courses": (context) => const Courses(),
        "/profile": (context) => const Profile(),
      },
    );
  }
}
