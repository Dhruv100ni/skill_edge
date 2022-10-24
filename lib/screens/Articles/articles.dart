import 'dart:convert';

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
    // await Future.delayed(const Duration(seconds: 2));
    var articleJSON =
        await rootBundle.loadString("assets/sample_data/articles.json");
    var decodedData = jsonDecode(articleJSON);
    // print(decodedData);
    articleData = List.from(decodedData["articles"])
        .map<ArticleModel>((article) => ArticleModel.fromMap(article))
        .toList();
    //mapData = decodedData["articles"];
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
