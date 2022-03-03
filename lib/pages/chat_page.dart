import 'package:chat/models/user.dart';
import 'package:chat/services/chat_service.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/chat_input.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    final User? userToChat = chatService.userToChat;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                child: Text(
                    userToChat != null
                        ? userToChat.name.substring(0, 2)
                        : "NaN",
                    style: const TextStyle(fontSize: 12)),
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(userToChat != null ? userToChat.name : "User",
                  style: const TextStyle(color: Colors.black87, fontSize: 12)),
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

  void _addMessage(String text) {
    final ChatMessage message = ChatMessage(
      message: text,
      uid: "12812871",
      animationController: AnimationController(
          vsync:
              this, // The This only works when we add the TickerProviderStateMixin
          duration: const Duration(milliseconds: 300)),
    );
    setState(() {
      _messages.insert(0, message);
      message.animationController.forward(); // Start the animation
    });
  }

  @override
  void dispose() {
    // TODO: OFF Socket listening
    // Clear all the controllers
    for (ChatMessage message in _messages) {
      message.animationController.dispose(); // Clear the controller
    }
    super.dispose();
  }
}
