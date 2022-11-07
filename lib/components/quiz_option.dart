import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  final String option;
  final String value;
  const QuizOption({super.key, required this.option, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
            child: Text(
              option,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
