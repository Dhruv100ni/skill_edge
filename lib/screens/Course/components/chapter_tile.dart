import "package:flutter/material.dart";
import 'package:skill_edge/models/chapter_model.dart';

class ChapterTile extends StatelessWidget {
  final int ind;
  final ChapterModel chapter;
  const ChapterTile({super.key, required this.ind, required this.chapter});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(chapter.title),
    );
  }
}
