import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'package:chat/models/user.dart';
import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/enums/authentication.enum.dart';

class AuthService with ChangeNotifier {
  User? user;
  bool _authenticating = false;
  final _storage = const FlutterSecureStorage(); // Stporge for save the token

  // Static method for get the token
  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: auth.token.name);
    return token;
  }

  // Static method for delete the token
  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: auth.token.name);
  }

  bool get authenticating => _authenticating;

  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners(); // Notify all the listeners for re-rendering
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;

    final dto = {
      'email': email,
      'password': password
    }; // Element for make the login
    Uri url = Uri.parse('${Environment.API_URL}/login'); // Url for login
    final http.Response response = await http.post(url,
        body: jsonEncode(dto), headers: {'content-type': 'application/json'});

    authenticating = false;
    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      user = loginResponse.user;
      await _saveSessionToken(loginResponse.token); // Save the token
      return loginResponse.ok; // TRUE
    }
    return false;
  }

  Future register(String email, String name, String password) async {
    authenticating = true;

    final dto = {'email': email, 'name': name, 'password': password};
    Uri url = Uri.parse('${Environment.API_URL}/login/new');
    final http.Response response = await http.post(url,
        body: jsonEncode(dto), headers: {'content-type': 'application/json'});

    authenticating = false;
    if (response.statusCode == 200) {
      final registerResponse = loginResponseFromJson(response.body);
      user = registerResponse.user;
      await _saveSessionToken(registerResponse.token);
      return registerResponse.ok;
    }
    final registerResponse = jsonDecode(response.body);
    return registerResponse["message"]; // We can send a message or a bool
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: auth.token.name);

    Uri url = Uri.parse('${Environment.API_URL}/login/renovate');

    final http.Response response = await http.get(url,
        headers: {'contentType': 'application/json', 'x-token': '$token'});

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      user = loginResponse.user;
      await _saveSessionToken(loginResponse.token); // Save the token renovated
      return true;
    }
    logOut();
    return false;
  }

  Future _saveSessionToken(String token) async {
    return await _storage.write(key: auth.token.name, value: token);
  }

  Future logOut() async {
    await _storage.delete(key: auth.token.name);
  }
}
