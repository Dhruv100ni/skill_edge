import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:skill_edge/components/navigation_menu.dart';
import 'package:skill_edge/models/article_model.dart';
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
    // print(allData);
    articleData = List.from(allData)
        .map<ArticleModel>((article) => ArticleModel.fromMap(article))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
