import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputChat extends StatefulWidget {
  const InputChat({Key? key}) : super(key: key);

  @override
  State<InputChat> createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> {
  Widget _renderSendButton() {
    return Platform.isIOS
        ? CupertinoButton(onPressed: () {}, child: const Text("Send"))
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.blue[400],
                ),
                onPressed: () {}),
          );
  }

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  _handleSubmitted(String text) {
    _textController.clear(); // Clear text field
    _focusNode.requestFocus(); // Mantained the keyboard visible
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Flexible(
              child: TextField(
                  controller: _textController,
                  focusNode: _focusNode, // The add the foucs when we want
                  onSubmitted: _handleSubmitted,
                  decoration:
                      const InputDecoration.collapsed(hintText: "Message"))),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: _renderSendButton())
        ],
      ),
    ));
  }
}
