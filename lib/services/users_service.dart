import 'package:chat/models/users_response.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      Uri url = Uri.parse('${Environment.API_URL}/users');
      final token = await AuthService.getToken();
      final http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': '$token',
      });
      final users = usersResponseFromJson(response.body);
      return users.users;
    } catch (error) {
      return [];
    }
  }
}
