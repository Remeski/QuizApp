import 'package:flutter/material.dart';

class AnswerTile extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final String answer;
  bool isSelected = false;

  AnswerTile({this.onChanged, this.answer});

  @override
  _AnswerTileState createState() => _AnswerTileState();
}

class _AnswerTileState extends State<AnswerTile> {
  var activeColor = Colors.grey[300];
  var unactiveColor = Colors.white;

  void buttonPressed() {
    setState(() {
      if (widget.isSelected) {
        widget.isSelected = false;
      } else {
        widget.isSelected = true;
      }
    });
    widget.onChanged(widget.isSelected);
  }

  Color getColor() {
    if (widget.isSelected) {
      return activeColor;
    }
    return unactiveColor;
  }

  IconData getIcon() {
    var icon = Icons.check_box_outline_blank;
    if (widget.isSelected) {
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
