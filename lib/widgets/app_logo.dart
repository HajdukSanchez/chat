import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.only(top: 50),
      width: 170,
      child: Column(
        children: const [
          Image(image: AssetImage("assets/images/tag-logo.png")),
          SizedBox(height: 20),
          Text(
            "Messenger",
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    ));
  }
}
