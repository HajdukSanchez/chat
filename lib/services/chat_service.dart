import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/models/messages_response.dart';
import 'package:chat/models/messages.dart';
import 'package:chat/models/user.dart';

class ChatService with ChangeNotifier {
  User? userToChat;

  Future<List<Message>> getChatMessages(String userID) async {
    Uri url = Uri.parse('${Environment.API_URL}/messages/$userID');
    final http.Response response = await http.get(url, headers: {
      'content-type': 'application/json',
      'x-token': '${await AuthService.getToken()}'
    });

    final messagesResponse = messagesResponseFromJson(response.body);
    return messagesResponse.messages;
  }
}
