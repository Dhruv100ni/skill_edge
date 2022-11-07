import 'package:flutter/material.dart';
import 'package:skill_edge/components/quiz_option.dart';

class Question extends StatefulWidget {
  final String question;
  final String A;
  final String B;
  final String C;
  final String D;
  final String ans;
  const Question({super.key, required this.question, required this.A, required this.B, required this.C, required this.D, required this.ans});

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
                    widget.question,
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
                    child: QuizOption(option: "A", value: widget.A)
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 177, 209, 209)
                    ),
                    onPressed: (){},
                    child: QuizOption(option: "B", value: widget.B)
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 177, 209, 209)
                    ),
                    onPressed: (){},
                    child: QuizOption(option: "C", value: widget.C)
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 177, 209, 209)
                    ),
                    onPressed: (){},
                    child: QuizOption(option: "D", value: widget.D)
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
