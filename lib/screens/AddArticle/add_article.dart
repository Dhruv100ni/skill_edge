import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";

import '../../components/landing_page.dart';

class AddArticle extends StatefulWidget {
  const AddArticle({super.key});

  @override
  State<AddArticle> createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();
  final TextEditingController url = TextEditingController();
  final TextEditingController tldr = TextEditingController();

  void addArticle() {
    print(title.text.trim() + " " + title.text.trim().length.toString());
    if (title.text.trim().length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: const Text("A title to your article is mandatory"),
                  actions: [
                    ElevatedButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ]));
      return;
    }
    if (body.text.trim().split(" ").length < 80) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: const Text(
                      "Content size is less than 80 words, kindly put in a few more words!"),
                  actions: [
                    ElevatedButton(
                      child: const Text("Alright"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ]));
      return;
    }
    db
        .collection("articles")
        .add({
          "content": body.text.trim(),
          "courseID": "",
          "image": url.text.trim(),
          "rating": "0",
          "title": title.text.trim(),
          "tldr": tldr.text.trim()
        })
        .then((value) => showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(title: const Text("Article Submitted!"), actions: [
                  ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage()));
                    },
                  )
                ])))
        .onError((e, _) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: Text("Error submitting article: $e"),
                    actions: [
                      ElevatedButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SKILL EDGE"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Add Article",
              style: TextStyle(fontWeight: FontWeight.w600),
              textScaleFactor: 1.5,
            ),
            SizedBox(
              height: 20.0,
            ),
            const Text(
              "Enter a Title",
              textScaleFactor: 1.2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 800),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffE8ECF4), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 121, 48, 181), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: const Color(0xffE8ECF4),
                  filled: true,
                  hintText: "What will you name it?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Enter a Description (optional)",
              textScaleFactor: 1.2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 800),
              child: TextField(
                controller: tldr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffE8ECF4), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 121, 48, 181), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: const Color(0xffE8ECF4),
                  filled: true,
                  hintText: "A short summary of your masterpeice",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            const Text(
              "Paste an Image URL (optional)",
              textScaleFactor: 1.2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 800),
              child: TextField(
                controller: url,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffE8ECF4), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 121, 48, 181), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: const Color(0xffE8ECF4),
                  filled: true,
                  hintText: "Images can capture more attention",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            const Text(
              "Article Content (min 80 words)",
              textScaleFactor: 1.2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 800),
              child: TextField(
                minLines: 10,
                maxLines: 50,
                controller: body,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffE8ECF4), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 121, 48, 181), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: const Color(0xffE8ECF4),
                  filled: true,
                  hintText: "Write your heart out!",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => addArticle(),
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Row(
                      children: [
                        Text("Add Article"),
                        SizedBox(
                          width: 1,
                        ),
                        Icon(Icons.add)
                      ],
                    ),
                  ),
                ),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll<Color>(Colors.white),
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
              ),
            )
          ],
        ),
      )),
    );
  }
}
