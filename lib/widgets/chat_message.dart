import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final String uid;

  const ChatMessage({Key? key, required this.message, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: uid == "123" ? _buildMyMessage() : _buildContactMessage(),
    );
  }

  Widget _buildMyMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        margin: const EdgeInsets.only(left: 50, right: 16, bottom: 5),
        decoration: const BoxDecoration(
            color: Color(0xff4D9EF6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.zero,
            )),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildContactMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        margin: const EdgeInsets.only(left: 16, right: 50, bottom: 8),
        decoration: const BoxDecoration(
            color: Color(0xffE4E5E8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.zero,
            )),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
