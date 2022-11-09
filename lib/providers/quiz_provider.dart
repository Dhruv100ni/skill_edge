import 'dart:collection';

import "package:flutter/material.dart";

class QuizProvider with ChangeNotifier {

  Map<int, String> answers = HashMap();

  String? getValue(int id){
    if(answers.containsKey(id)){
      return answers[id];
    }

    return "";
  }

  void selectOption(int id, String option){
    //answers.update(id, (value) => option);
    answers[id] = option;
    notifyListeners();
  }

  void clearMap(){
    answers.clear();
  }
}
