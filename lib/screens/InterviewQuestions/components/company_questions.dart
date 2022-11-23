import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skill_edge/models/companyQues_model.dart';

import '../../../models/company_model.dart';

class CompanyQuestions extends StatefulWidget {
  final Company comp;
  const CompanyQuestions({super.key, required this.comp});

  @override
  State<CompanyQuestions> createState() => _CompanyQuestionsState();
}

class _CompanyQuestionsState extends State<CompanyQuestions> {
  List<CompanyQuesModel> questions = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    // Fetch data from cloud firestore
    final FirebaseFirestore db = FirebaseFirestore.instance;
    var querySnapshot = await db
        .collection("companies")
        .doc(widget.comp.id)
        .collection("questions")
        .get();
    final allData = querySnapshot.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    questions = List.from(allData)
        .map<CompanyQuesModel>((ques) => CompanyQuesModel.fromMap(ques))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SKILL EDGE"),
          backgroundColor: Colors.white,
        ),
        body: questions.length != 0
            ? Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) => ExpansionTile(
                    childrenPadding: EdgeInsets.all(8),
                    title: Text(questions[index].question, style: TextStyle(fontWeight: FontWeight.w500)),
                    children: <Widget>[Text(questions[index].ans, style: TextStyle(fontSize: 16))],
                  ),
                  itemCount: questions.length,
                ))
            : Center(child: CircularProgressIndicator()));
  }
}
