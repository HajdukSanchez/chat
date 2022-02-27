import 'dart:convert';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:chat/global/environment.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  User? user;
  bool _authenticating = false;

  bool get authenticating => _authenticating;

  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners(); // Notify all the listeners for re-rendering
  }

  Future login(String email, String password) async {
    authenticating = true;

    final dto = {
      'email': email,
      'password': password
    }; // Element for make the login
    Uri url = Uri.parse('${Environment.API_URL}/login'); // Url for login
    final http.Response response = await http.post(url,
        body: jsonEncode(dto), headers: {'content-type': 'application/json'});

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      this.user = loginResponse.user;
    }
  }
}