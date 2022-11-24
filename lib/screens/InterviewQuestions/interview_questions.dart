import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skill_edge/models/companyQues_model.dart';

import '../../models/company_model.dart';
import 'components/company_tile.dart';

class InterviewQuestions extends StatefulWidget {
  const InterviewQuestions({super.key});

  @override
  State<InterviewQuestions> createState() => _InterviewQuestionsState();
}

class _InterviewQuestionsState extends State<InterviewQuestions> {

  List<Company> companies = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // Getting data from cloud firestore
    final FirebaseFirestore db = FirebaseFirestore.instance;
    var companyCollection = await db.collection("companies").get();
    final companyData = companyCollection.docs.map((doc){
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    companies = List.from(companyData).map<Company>((comp)=>Company.fromMap(comp)).toList();
    

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: companies.length!=0 ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: companies.length,
                  itemBuilder: (context, index) =>
                      CompanyTile(comp: companies[index])),
            ),
          ],
        ),
      ) : Center(child: CircularProgressIndicator())
    );
  }
}