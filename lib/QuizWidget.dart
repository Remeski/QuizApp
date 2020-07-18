import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AnswerTile.dart';
import 'Question.dart';
import 'QuizModel.dart';

class QuizWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  @override
  Widget build(BuildContext context) {
    Future<bool> loadFuture = context.watch<QuizModel>().loadQuestions();
    List<Answer> submittedAnswers = [];
    return FutureBuilder(
        future: loadFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            var question = context.watch<QuizModel>().question;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    question.name,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: question.answerList.length,
                        itemBuilder: (context, i) {
                          context.watch<QuizModel>();
                          return AnswerTile(
                              onChanged: (value) {
                                if (value) {
                                  submittedAnswers.add(question.answerList[i]);
                                } else {
                                  var index = submittedAnswers
                                      .indexOf(question.answerList[i]);
                                  submittedAnswers.removeAt(index);
                                }
                              },
                              answer: question.answerList[i].name);
                        }),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        context.read<QuizModel>().submit(submittedAnswers);
                      },
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Answer", style: TextStyle(fontSize: 18)),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.done,
                              size: 27,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
