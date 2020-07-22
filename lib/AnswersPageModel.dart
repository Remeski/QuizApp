import 'dart:convert';
import 'package:http/http.dart' as http;

class AnswersPageModel {
  final _url = "https://script.google.com/macros/s/AKfycbzt1ZVhnfS16Z6nATrHlLvldWlHn7RGfYNyw8UVDh-4Oif4Lug/exec?useranswers";

  List userAnswers;

  Future<bool> getUserAnswers() async {
    var isDone = false;
    await http.get(_url).then((response) {
      userAnswers = jsonDecode(response.body);
      isDone = true;
    });
    return isDone;
  }

}