import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlertDialog(BuildContext context, String title, String message,
    {String buttonText = "Accept"}) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(buttonText),
                  elevation: 5,
                  textColor: Colors.blue,
                )
              ],
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: [
                  CupertinoDialogAction(
                      child: Text(buttonText),
                      onPressed: () => Navigator.pop(context))
                ]));
  }
}
