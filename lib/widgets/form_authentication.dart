import 'package:flutter/material.dart';

class FormAuthentication extends StatefulWidget {
  final String actionText;

  const FormAuthentication({Key? key, required this.actionText})
      : super(key: key);

  @override
  State<FormAuthentication> createState() => _FormAuthenticationState();
}

class _FormAuthenticationState extends State<FormAuthentication> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(),
        const TextField(),
        ElevatedButton(
          onPressed: () {},
          child: Text(widget.actionText),
        )
      ],
    );
  }
}
