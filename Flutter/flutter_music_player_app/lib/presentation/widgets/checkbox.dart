import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/res/colors.dart';

class MyCheckBox extends StatefulWidget {
  MyCheckBox({Key? key, this.defaultState = false, required this.text}) : super(key: key);

  bool defaultState;
  final String text;

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      checkColor: MyColors.darkBlue,
      title: Text(widget.text),
      value: widget.defaultState,
      onChanged: (newValue) {
        setState(() {
          if (newValue != null) {
            widget.defaultState = newValue;
          }
        });
      },
      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
    );
  }
}
