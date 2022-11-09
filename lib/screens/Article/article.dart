import "package:flutter/material.dart";
import 'package:skill_edge/models/article_model.dart';

class Article extends StatelessWidget {
  final ArticleModel article;
  const Article({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SKILL EDGE"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: article.image == ""
                      ? Image.asset("assets/images/logo.jpg")
                      : Image.network(article.image),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  article.title,
                  textAlign: TextAlign.left,
                  textScaleFactor: 2.5,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  article.content,
                  textAlign: TextAlign.justify,
                ),
              )
            ]),
      ),
    );
  }
}
