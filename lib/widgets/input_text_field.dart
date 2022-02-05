import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final bool textObscure;
  final Icon icon;
  final TextInputType keyboardType;
  final TextEditingController textController; // To get the input text value

  const InputTextField({
    Key? key,
    required this.icon,
    required this.textController,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(right: 25, left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        autocorrect: true,
        obscureText: true,
        controller: textController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: icon,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
