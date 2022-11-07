import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skill_edge/components/article_template.dart';
import 'package:skill_edge/providers/user_provider.dart';

import '../../models/article_model.dart';

class Home extends StatefulWidget {
  final TabController tabController;
  const Home({super.key, required this.tabController});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //add provider here
  final String username = "John Doe";
  List<ArticleModel> articleData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // Getting data from cloud firestore
    final FirebaseFirestore db = FirebaseFirestore.instance;
    var querySnapshot = await db.collection("articles").get();
    final allData = querySnapshot.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    // print(allData);
    articleData = List.from(allData)
        .map<ArticleModel>((article) => ArticleModel.fromMap(article))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Row(
          children: [
            const Text("Welcome ", style: TextStyle(fontSize: 20)),
            Text(context.watch<CurrentUser>().username,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            const Text("Latest Articles",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            const Spacer(),
            TextButton(
                onPressed: () {
                  widget.tabController.animateTo(2);
                },
                child: const Text("See all"))
          ],
        ),
        Container(
          constraints: const BoxConstraints(maxHeight: 180),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articleData.length,
            itemBuilder: ((context, index) =>
                ArticleTemplate(article: articleData[index])),
          ),
        ),
        Row(
          children: [
            const Text("My Courses",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            const Spacer(),
            TextButton(
                onPressed: () {
                  widget.tabController.animateTo(1);
                },
                child: const Text("See all"))
          ],
        ),
        Container(
          constraints: const BoxConstraints(maxHeight: 180),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articleData.length,
            itemBuilder: ((context, index) =>
                ArticleTemplate(article: articleData[index])),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text("Any Doubts?", style: TextStyle(fontSize: 18)),
        const SizedBox(
          height: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Submit'))
          ],
        ),
      ],
    );
  }
}
