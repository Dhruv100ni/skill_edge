import "package:flutter/material.dart";
import 'package:skill_edge/models/article_model.dart';

class ArticleTile extends StatelessWidget {
  final ArticleModel article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        child: ListTile(
          onTap: () {},
          leading: Image.network(
            article.image,
            width: 100,
            // height: 300,
          ),
          title: Text(article.title),
          subtitle: Text(article.tldr),
          trailing: const Text("Read"),
        ),
      ),
    );
  }
}
