import "package:flutter/material.dart";
import 'package:skill_edge/models/article_model.dart';

class Article extends StatelessWidget {
  final ArticleModel article;
  const Article({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: const Text("SKILL EDGE"),
        ),
        // centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(children: [
        Text(article.title),
      ]),
    );
  }
}
