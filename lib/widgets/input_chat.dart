import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputChat extends StatefulWidget {
  const InputChat({Key? key}) : super(key: key);

  @override
  State<InputChat> createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isButtonEnabled = false;

  _handleSubmitted(String text) {
    _textController.clear(); // Clear text field
    _focusNode.requestFocus(); // Mantained the keyboard visible
    setState(() {
      _isButtonEnabled = false;
    });
  }

  Widget _renderSendButton() {
    if (Platform.isIOS) {
      return CupertinoButton(
          onPressed: _isButtonEnabled
              ? () => _handleSubmitted(_textController.text.trim())
              : null,
          child: const Text("Send"));
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: IconTheme(
          data: IconThemeData(color: Colors.blue[400]),
          child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon(
                Icons.send,
              ),
              onPressed: _isButtonEnabled
                  ? () => _handleSubmitted(_textController.text.trim())
                  : null),
        ),
      );
    }
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
                  onChanged: (text) {
                    setState(() {
                      (text.trim().isNotEmpty)
                          ? _isButtonEnabled = true
                          : _isButtonEnabled = false;
                    });
                  },
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
