import 'dart:convert';
import 'dart:math';
import 'package:CodeQuiz/Question.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class QuizModel extends ChangeNotifier {
  List<Question> _questionList = List<Question>();
  Question _question;
  final _url = "https://script.google.com/macros/s/AKfycbzt1ZVhnfS16Z6nATrHlLvldWlHn7RGfYNyw8UVDh-4Oif4Lug/exec";


  Future<bool> loadQuestions() async {
    bool isDone = false;
    await http.get(_url).then((response) {
      var jsonQuestionList = jsonDecode(response.body);
      for(var i = 0; i < jsonQuestionList.length; i++) {
        Question item = Question.fromJson(jsonQuestionList[i]);
        _questionList.add(item);
      }
      isDone = true;
    });
    loadQuestion();
    return isDone;
  }

  
  Question get question => _question;

  void loadQuestion() {
    int randomNum = Random().nextInt(_questionList.length);
    _question = _questionList[randomNum];
    
  } 
  void submit(List<Answer> submittedAnswers) {
    print("Answered:");
    submittedAnswers.forEach((element) {print("\t- ${element.name}");});
    loadQuestion();
    notifyListeners();
  }

}