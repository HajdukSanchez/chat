// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Function() buttonOnPress;

  const Button({
    Key? key,
    required this.buttonText,
    required this.buttonOnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      shape: const StadiumBorder(),
      color: Colors.blue,
      onPressed: buttonOnPress,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
            child: Text(buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 17))),
      ),
    );
  }
}
