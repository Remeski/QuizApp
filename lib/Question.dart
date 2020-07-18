class Question {
  final String name;
  final List<Answer> answerList;

  const Question(this.name, this.answerList);

  factory Question.fromJson(dynamic json) {
    List<Answer> parseListJson(dynamic json) {
      var list = List<Answer>();
      for (var i = 0; i < json.length; i++) {
        list.add(Answer.fromJson(json[i]));
      }
      return list;
    }
    var question = Question(json["question"], parseListJson(json["answers"]));
    return question;
  }
}

class Answer {
  final String name;
  final bool rightAnswer;
  Answer(this.name, this.rightAnswer);

  factory Answer.fromJson(dynamic json) {
    return Answer(json["answer"], json["isRightAnswer"]);
  }
}
