import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skill_edge/components/article_template.dart';

import '../../models/article_model.dart';

class Home extends StatefulWidget {
  final TabController tabController;
  const Home({super.key, required this.tabController});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String username = "John Doe";
  List<ArticleModel> articleData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var articleJSON =
        await rootBundle.loadString("assets/sample_data/articles.json");
    var decodedData = jsonDecode(articleJSON);
    articleData = List.from(decodedData["articles"])
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
            Text(username,
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
