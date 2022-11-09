import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:skill_edge/components/quiz_option.dart';
import 'package:skill_edge/providers/quiz_provider.dart';





class Question extends StatefulWidget {
  final String question;
  final String A;
  final String B;
  final String C;
  final String D;
  final int id;
  const Question(
      {super.key,
      required this.question,
      required this.A,
      required this.B,
      required this.C,
      required this.D,
      required this.id});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question>{

  void chooseOption(String opt){
    if(context.read<QuizProvider>().getValue(widget.id)==opt){
      context.read<QuizProvider>().selectOption(widget.id, "");
    }
    else{
      context.read<QuizProvider>().selectOption(widget.id, opt);
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
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
                        backgroundColor: context.read<QuizProvider>().getValue(widget.id)=="A" ? Color.fromARGB(255, 88, 138, 138) : Color.fromARGB(255, 177, 209, 209)),
                    onPressed: () {chooseOption("A");},
                    child: QuizOption(option: "A", value: widget.A)),
                const SizedBox(height: 40),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.read<QuizProvider>().getValue(widget.id)=="B" ? Color.fromARGB(255, 88, 138, 138) : Color.fromARGB(255, 177, 209, 209)),
                    onPressed: () {chooseOption("B");},
                    child: QuizOption(option: "B", value: widget.B)),
                const SizedBox(height: 40),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.read<QuizProvider>().getValue(widget.id)=="C" ? Color.fromARGB(255, 88, 138, 138) : Color.fromARGB(255, 177, 209, 209)),
                    onPressed: () {chooseOption("C");},
                    child: QuizOption(option: "C", value: widget.C)),
                const SizedBox(height: 40),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.read<QuizProvider>().getValue(widget.id)=="D" ? Color.fromARGB(255, 88, 138, 138) : Color.fromARGB(255, 177, 209, 209)),
                    onPressed: () {chooseOption("D");},
                    child: QuizOption(option: "D", value: widget.D))
              ],
            ),
          )
        ],
      ),
    );
  }
}
