import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skill_edge/components/quiz_option.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    'Which space agency has decided to carry out first all-female spacewalk at the International Space Station(ISS)?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 177, 209, 209)
                    ),
                    onPressed: (){},
                    child: QuizOption(option: "A", value: "Roscosmos")
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 177, 209, 209)
                    ),
                    onPressed: (){},
                    child: QuizOption(option: "B", value: "NASA")
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 177, 209, 209)
                    ),
                    onPressed: (){},
                    child: QuizOption(option: "C", value: "ISRO")
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 177, 209, 209)
                    ),
                    onPressed: (){},
                    child: QuizOption(option: "D", value: "JAXA",)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
