import "package:flutter/material.dart";
import 'package:skill_edge/screens/InterviewQuestions/components/company_questions.dart';
import '../../../models/company_model.dart';

class CompanyTile extends StatelessWidget {
  final Company comp;

  const CompanyTile({super.key, required this.comp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CompanyQuestions(comp: comp);
            }));
          },
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              constraints: BoxConstraints(minWidth: 90),
              child: comp.image == ""
                  ? Image.asset("assets/images/logo.jpg")
                  : Image.network(
                      comp.image,
                      width: 100,
                      // height: 300,
                    ),
            ),
          ),
          trailing: const Text("Read Questions", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
