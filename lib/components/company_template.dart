import 'package:flutter/material.dart';
import 'package:skill_edge/screens/InterviewQuestions/components/company_questions.dart';
import '../models/company_model.dart';

class CompanyTemplate extends StatelessWidget {
  final Company comp;
  const CompanyTemplate({super.key, required this.comp});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CompanyQuestions(comp: comp);
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
                      child: comp.image == ""
                          ? Image.asset("assets/images/logo.jpg")
                          : Image.network(comp.image)),
                ),
                Text(
                  comp.name,
                  style: const TextStyle(fontWeight: FontWeight.w800),
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
