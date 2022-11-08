import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../screens/Article/article.dart';

class ArticleTemplate extends StatelessWidget {
  final ArticleModel article;
  const ArticleTemplate({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Article(article: article);
        }));
      },
      child: Card(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 130),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                      height: 120,
                      child: article.image == ""
                          ? Image.asset("images/logo.jpg")
                          : Image.network(article.image)),
                ),
                Text(
                  article.title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  article.tldr,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
