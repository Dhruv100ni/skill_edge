import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  final String option;
  final String value;
  const QuizOption({super.key, required this.option, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 400, minHeight: 50),
      alignment: Alignment.centerLeft,
      child: Text(
        value,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
