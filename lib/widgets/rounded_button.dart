import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonTitle;
  final Color buttonColor;
  final Function onPressed;

  const RoundedButton({this.buttonColor, this.buttonTitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonTitle,
          ),
        ),
      ),
    );
  }
}
