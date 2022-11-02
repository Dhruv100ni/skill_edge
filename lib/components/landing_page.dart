import 'package:flutter/material.dart';
import 'package:skill_edge/screens/Courses/courses.dart';

import '../screens/Articles/articles.dart';
import '../screens/Homepage/home.dart';
import '../screens/Profile/edit_profile.dart';
import '../screens/Profile/profile.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
                    Tab(text: 'Profile')
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
                  const Courses(),
                  const Articles(),
                  const EditProfilePage()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
