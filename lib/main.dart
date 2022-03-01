import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:chat/routes/routes.dart';
import 'package:chat/enums/routes.enum.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AuthService(),
      )
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
