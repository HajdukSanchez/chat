import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String textQuestion;
  final String textOption;
  final Function() onTap;

  const Labels(
      {Key? key,
      required this.textQuestion,
      required this.textOption,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(textQuestion,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.w300)),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            textOption,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
