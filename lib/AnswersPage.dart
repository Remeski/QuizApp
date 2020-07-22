import 'package:CodeQuiz/AnswersPageModel.dart';
import 'package:CodeQuiz/Question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class AnswersPage extends StatefulWidget {
  final List<UserAnswer> userAnswers;
  AnswersPage(this.userAnswers);

  @override
  State<StatefulWidget> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswersPage> {
  var userAnswers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userAnswers = widget.userAnswers;
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => AnswersPageModel(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Answers",
              style: TextStyle(color: Colors.white),
            ),
            //centerTitle: true,
            elevation: 0,
          ),
          body: Consumer<AnswersPageModel>(builder: (context, data, _) {
            var future = data.getUserAnswers();
            return FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: userAnswers.length,
                        itemBuilder: (context, i) {
                          var otherUserAnswers = data.userAnswers;
                          var percentageList;
                          for (var k = 0; k < otherUserAnswers.length; k++) {
                            if (otherUserAnswers[k]["question"] ==
                                userAnswers[i].question.name) {
                              percentageList = PercentageOfAnswers(
                                      otherUserAnswers[k]["answers"])
                                  .returnlist;
                            }
                          }
                          return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Question: ${userAnswers[i].question.name}"),
                                    Text("You answered:"),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          userAnswers[i].answerslist.length,
                                      itemBuilder: (context, j) {
                                        return Text(
                                            "- " +
                                                userAnswers[i]
                                                    .answerslist[j]
                                                    .name,
                                            textAlign: TextAlign.center);
                                      },
                                    ),
                                    Text("What other people answered: "),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: percentageList.length,
                                      itemBuilder: (context, j) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          Text("- " +
                                              percentageList[j]["answer"] + ": "),
                                          Text(percentageList[j]["percentage"], style: TextStyle(fontWeight: FontWeight.bold))
                                        ]);
                                      },
                                    ),
                                  ],
                                ),
                              ));
                        });
                  }
                  if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                });
          }),
        ));
  }
}

class PercentageOfAnswers {
  List json;
  List returnlist = [];

  PercentageOfAnswers(this.json) {
    getPercentage(json);
  }

  void getPercentage(List list) {
    int answersTotal = 0;
    for (var i = 0; i < list.length; i++) {
      answersTotal += int.parse(list[i]["useranswers"]);
    }
    for (var i = 0; i < list.length; i++) {
      var item = {};
      item["answer"] = list[i]["answer"].toString();
      item["percentage"] =
          (int.parse(list[i]["useranswers"]) / answersTotal * 100)
                  .round()
                  .toString() +
              "%";
      returnlist.add(item);
    }
  }
}
