import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/widgets/button.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/app_logo.dart';
import 'package:chat/enums/routes.enum.dart';
import 'package:chat/helpers/show_message.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/input_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                    const AppLogo(
                      title: "Register",
                    ),
                    const _FormRegister(),
                    Labels(
                      textQuestion: "You already have and an account ?",
                      textOption: 'Go to login',
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, routes.login.name);
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

class _FormRegister extends StatefulWidget {
  const _FormRegister({Key? key}) : super(key: key);

  @override
  State<_FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<_FormRegister> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    void onRegister() async {
      FocusScope.of(context).unfocus(); // Unfocus the keyboard
      final register = await authService.register(emailController.text.trim(),
          nameController.text.trim(), passwordController.text.trim());
      if (register == true) {
        socketService.connect();
        Navigator.pushReplacementNamed(
            context, routes.users.name); // Go to home
      } else {
        // Show error message
        showAlertDialog(context, "Error in register", register);
      }
    }

    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            InputTextField(
              icon: const Icon(Icons.perm_identity),
              hintText: 'Name',
              textController: nameController,
            ),
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
              buttonText: "Create account",
              buttonOnPress: onRegister,
            )
          ],
        ));
  }
}
