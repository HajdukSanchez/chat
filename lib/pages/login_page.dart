import 'package:chat/helpers/show_message.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/enums/routes.enum.dart';
import 'package:chat/services/auth_services.dart';

import 'package:chat/widgets/app_logo.dart';
import 'package:chat/widgets/button.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/input_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), // The scroll physics
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.95, // 95% of the screen height
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const AppLogo(),
                    const _FormLogin(),
                    Labels(
                      textOption: 'Create one',
                      textQuestion: "You don't have an account ?",
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, routes.register.name);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: const Text(
                        "Terms and conditions",
                        style: TextStyle(fontWeight: FontWeight.w200),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}

class _FormLogin extends StatefulWidget {
  const _FormLogin({Key? key}) : super(key: key);

  @override
  State<_FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<_FormLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    void onLogin() async {
      FocusScope.of(context).unfocus(); // Unfocus the keyboard
      final login = await authService.login(
          emailController.text.trim(), passwordController.text.trim());
      if (login) {
        Navigator.pushReplacementNamed(
            context, routes.users.name); // Go to home
      } else {
        // Show error message
        showAlertDialog(context, "Erro Login", "Bad credentials");
      }
    }

    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            InputTextField(
                icon: const Icon(Icons.email_outlined),
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textController: emailController),
            InputTextField(
              icon: const Icon(Icons.lock_outline),
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              textObscure: true,
              textController: passwordController,
            ),
            const SizedBox(height: 15),
            Button(
              buttonText: "Login",
              buttonOnPress: authService.authenticating ? () {} : onLogin,
            )
          ],
        ));
  }
}
