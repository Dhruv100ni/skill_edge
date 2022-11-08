import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:skill_edge/components/navigation_menu.dart';
import 'package:skill_edge/models/article_model.dart';
import 'package:skill_edge/screens/AddArticle/add_article.dart';
import 'package:skill_edge/screens/Articles/components/article_tile.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  List<ArticleModel> articleData = [];
  //List mapData = [];

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
    articleData = List.from(allData)
        .map<ArticleModel>((article) => ArticleModel.fromMap(article))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // int n = articleData.length;
    // if (n > 0) {
    //   articleData = List.generate(10, (index) => articleData[index % n]);
    // }
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddArticle();
          }));
        },
        label: const Text(
          'Contribute',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: articleData.length,
                  itemBuilder: (context, index) =>
                      ArticleTile(article: articleData[index])),
            ),
          ],
        ),
      ),
    );
  }
}
