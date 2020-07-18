import 'package:CodeQuiz/QuizModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswerTile extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final String answer;

  AnswerTile({this.onChanged, this.answer});

  @override
  _AnswerTileState createState() => _AnswerTileState();
}

class _AnswerTileState extends State<AnswerTile> {
  bool isSelected = false;
  var activeColor = Colors.grey[300];
  var unactiveColor = Colors.white;

  void buttonPressed() {
    setState(() {
      if (isSelected) {
        isSelected = false;
      } else {
        isSelected = true;
      }
    });
    widget.onChanged(isSelected);
  }

  Color getColor() {
    if (isSelected) {
      return activeColor;
    }
    return unactiveColor;
  }

  IconData getIcon() {
    var icon = Icons.check_box_outline_blank;
    if (isSelected) {
      icon = Icons.check_box;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getColor(),
      child: ListTile(
        //contentPadding: EdgeInsets.symmetric(horizontal: 20),
        onTap: () {
          buttonPressed();
        },
        trailing: Icon(getIcon()),
        title: Text(widget.answer),
      ),
    );
  }
}
