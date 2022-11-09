import "package:flutter/material.dart";
import 'package:skill_edge/models/article_model.dart';
import 'package:skill_edge/screens/Article/article.dart';

class ArticleTile extends StatelessWidget {
  final ArticleModel article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Article(article: article);
          }));
        },
        leading: Container(
          constraints: BoxConstraints(minWidth: 90),
          child: article.image == ""
              ? Image.asset("images/logo.jpg")
              : Image.network(
                  article.image,
                  width: 100,
                  // height: 300,
                ),
        ),
        title: Text(article.title),
        subtitle: Text(article.tldr),
        trailing: const Text("Read"),
        isThreeLine: true,
      ),
    );
  }
}
