import 'package:flutter/material.dart';

import 'package:chat/widgets/chat_input.dart';
import 'package:chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];

  void _addMessage(String text) {
    final ChatMessage message = ChatMessage(
      message: text,
      uid: "12812871",
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                child: const Text("TE", style: TextStyle(fontSize: 12)),
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
              ),
              const SizedBox(
                height: 3,
              ),
              const Text("User",
                  style: TextStyle(color: Colors.black87, fontSize: 12)),
            ],
          ),
          centerTitle: true,
          elevation: 1,
        ),
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) => _messages[i],
              itemCount: _messages.length,
              // We start in the liast child of the list view like a real chat
              reverse: true,
            )),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.black12,
                        offset: Offset(0, 5))
                  ]),
              child: ChatInput(addMessage: _addMessage),
            )
          ],
        ));
  }
}
