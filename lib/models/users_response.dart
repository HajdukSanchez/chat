import 'dart:convert';

import 'package:chat/models/user.dart';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  UsersResponse({
    required this.ok,
    required this.message,
    required this.users,
  });

  bool ok;
  String message;
  List<User> users;

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        ok: json["ok"],
        message: json["message"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
