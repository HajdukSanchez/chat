import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/enums/routes.enum.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/chat_service.dart';

class UserListTile extends StatelessWidget {
  final User user;

  const UserListTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToUserChat() {
      final chatService = Provider.of<ChatService>(context, listen: false);
      chatService.userToChat = user;
      Navigator.pushNamed(context, routes.chat.name);
    }

    return ListTile(
        title: Text(user.name),
        subtitle: Text(
          user.email,
          style: const TextStyle(fontSize: 12),
        ),
        leading: CircleAvatar(
          child: Text(
            user.name.substring(0, 2),
          ),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: user.online ? Colors.green : Colors.red[300],
              borderRadius: BorderRadius.circular(100)),
        ),
        onTap: navigateToUserChat);
  }
}
