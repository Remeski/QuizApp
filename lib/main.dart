import 'package:CodeQuiz/AnswersPage.dart';
import 'package:CodeQuiz/QuizModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'QuizWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[100],
        appBarTheme: AppBarTheme(color: Colors.black)
      ),
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "very aWeSomE kysely App",
            style: TextStyle(color: Colors.white),
          ),
          //centerTitle: true,
          elevation: 0,
        ),
        body: ChangeNotifierProvider<QuizModel>(
            create: (context) => QuizModel(context: context), child: QuizWidget()));
  }
}
