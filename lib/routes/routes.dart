// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'package:chat/pages/users_page.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/enums/routes.enum.dart';

// Centralice the routes in the application
final Map<String, Widget Function(BuildContext)> appRoutes = {
  routes.users.name: (_) => const UsersPage(),
  routes.chat.name: (_) => const ChatPage(),
  routes.login.name: (_) => const LoginPage(),
  routes.register.name: (_) => const RegisterPage(),
  routes.loading.name: (_) => const LoadingPage(),
};
