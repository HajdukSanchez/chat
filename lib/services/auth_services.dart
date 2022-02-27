import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chat/global/environment.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Future login(String email, String password) async {
    final dto = {
      'email': email,
      'password': password
    }; // Element for make the login
    Uri url = Uri.parse('${Environment.API_URL}/login'); // Url for login
    final http.Response response = await http.post(url,
        body: jsonEncode(dto), headers: {'content-type': 'application/json'});
    print(response.body);
  }
}
