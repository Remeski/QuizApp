import 'package:CodeQuiz/Question.dart';
import 'package:flutter/material.dart';

class AnswersPage extends StatelessWidget {
  List<UserAnswer> userAnswers;
  AnswersPage(this.userAnswers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Answers",
            style: TextStyle(color: Colors.white),
          ),
          //centerTitle: true,
          elevation: 0,
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: userAnswers.length,
            itemBuilder: (context, i) {
              return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Question: ${userAnswers[i].question.name}"),
                        Text("You answered:"),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: userAnswers[i].answerslist.length,
                          itemBuilder: (context, j) {
                            return Text("- " + userAnswers[i].answerslist[j].name, textAlign: TextAlign.center );
                          },
                        )
                      ],
                    ),
                  ));
            }));
  }
}
