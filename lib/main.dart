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
      home: Home(),
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
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Code_Quiz",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          //centerTitle: true,
          elevation: 0,
        ),
        body: ChangeNotifierProvider<QuizModel>(create: (context) => QuizModel(), child:  QuizWidget())  
      );
  }
}
