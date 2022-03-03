import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:chat/routes/routes.dart';
import 'package:chat/enums/routes.enum.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => SocketService()),
      ChangeNotifierProvider(create: (_) => ChatService())
    ], child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Dont show debug banner
      title: 'Real Time Chat',
      initialRoute: routes.loading.name,
      routes: appRoutes,
    );
  }
}
