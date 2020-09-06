import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  var backgroundColor;
  var textColor;
  String txt;
  Function btnPressed;
  CustomButton(
      {this.backgroundColor, this.btnPressed, this.textColor, this.txt});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      child: RaisedButton(
          onPressed: btnPressed,
          color: backgroundColor,
          textColor: textColor,
          child: Text(
            txt,
            style: TextStyle(fontSize: 16),
          )),
    );
  }
}
