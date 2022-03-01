import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/users_page.dart';
import 'package:chat/services/auth_services.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // With this widget we can use a future to wait for the user to be authenticated
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text("Loading Page"),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final authenticated = await authService.isLoggedIn();
    if (authenticated) {
      socketService.connect();
      // We can make an animation to enter on the users screen
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const UsersPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    }
  }
}
