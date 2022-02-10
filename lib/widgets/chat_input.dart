import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function(String) addMessage;
  const ChatInput({Key? key, required this.addMessage}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isButtonEnabled = false;

  _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _textController.clear(); // Clear text field
      _focusNode.requestFocus(); // Mantained the keyboard visible
      widget.addMessage(text); // Send message to the parent
      setState(() {
        _isButtonEnabled = false;
      });
    }
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
