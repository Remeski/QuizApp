import 'dart:convert';
import 'dart:math';
import 'package:CodeQuiz/AnswersPage.dart';
import 'package:CodeQuiz/AnswersPageModel.dart';
import 'package:CodeQuiz/Question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizModel extends ChangeNotifier {
  final _url =
      "https://script.google.com/macros/s/AKfycbzt1ZVhnfS16Z6nATrHlLvldWlHn7RGfYNyw8UVDh-4Oif4Lug/exec";

  List<Question> _questionList = [];
  List<UserAnswer> userAnswers = [];

  Question _question;
  int questionIndex = 0;

  final BuildContext context;

  QuizModel({@required this.context});

  Question get question { 
    return _question;
  }

  int get remainingQuestions {
    var remainingQuestion = _questionList.length - questionIndex + 1;
    return remainingQuestion;
  }

  void loadQuestion() {
    if(_questionList.length - 1 < questionIndex) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AnswersPage(userAnswers)));
    } 
    else {
      _question = _questionList[questionIndex++];
    }
  }

  Future<bool> loadQuestions() async {
    bool isDone = false;

    List<Question> randomOrder(List list) {
      var randomOrderList = List<Question>();
      while(list.length > randomOrderList.length) {
        var randomNum = Random().nextInt(list.length );
        if (!randomOrderList.contains(list[randomNum])) {
          randomOrderList.add(list[randomNum]);
        }
      }
      return randomOrderList;
    }

    var questions = [];
    if (_questionList.isEmpty) {
      await http.get(_url).then((response) {
        var jsonQuestionList = jsonDecode(response.body);
        for (var i = 0; i < jsonQuestionList.length; i++) {
          Question item = Question.fromJson(jsonQuestionList[i]);
          questions.add(item);
        }
        isDone = true;
      });
      _questionList = randomOrder(questions);
      loadQuestion();
    } else
      isDone = true;
    return isDone;
  }

  Future<void> saveQuestion(UserAnswer ua) async {
    var list = "";
    for (var i = 0; i < ua.answerslist.length; i++) {
      list += ua.answerslist[i].name;
      if(i < ua.answerslist.length - 1) {
        list += ",";
      }
    }
    var bodyData = new Map<String, dynamic>();
    bodyData["name"] = ua.question.name;
    bodyData["answerslist"] = list;
    await http.post(_url, body: bodyData); 
  } 

  void _onLoading() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text("Saving your answers..."),
            ],
          ),
        ),
      );
    },
  );
}

  Future<void> submit(List<Answer> submittedAnswers) async {
    var userAnswer = UserAnswer(_question, submittedAnswers);
    if(questionIndex == _questionList.length) {
      _onLoading();
      await saveQuestion(userAnswer);
    }
    else {
      saveQuestion(userAnswer);
    }

    userAnswers.add(userAnswer);

    loadQuestion();
    notifyListeners();
  }
}
