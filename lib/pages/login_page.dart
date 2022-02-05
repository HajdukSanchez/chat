import 'package:flutter/material.dart';

import 'package:chat/widgets/app_logo.dart';
import 'package:chat/widgets/form_authentication.dart';
import 'package:chat/widgets/footer_authentication.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const AppLogo(),
          const FormAuthentication(
            actionText: "Login",
          ),
          const FooterAuthentication(
            textOption: 'Create one',
            textQuestion: "You don't have an account ?",
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: const Text(
              "Terms and conditions",
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
          )
        ],
      )),
    );
  }
}
