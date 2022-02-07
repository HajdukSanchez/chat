import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    User(online: true, name: "Jozek", email: "jozekhs@gmail.com", uid: "1"),
    User(online: false, name: "Andres", email: "jozekhs@gmail.com", uid: "2"),
    User(online: true, name: "Fernando", email: "jozekhs@gmail.com", uid: "3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My name",
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          // For example we can add an icon to close session
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black54,
              )),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
            )
          ],
        ),
        body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) => ListTile(
                  title: Text(users[i].name),
                  leading: CircleAvatar(
                    child: Text(users[i].name.substring(0, 2)),
                  ),
                  trailing: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: users[i].online ? Colors.green : Colors.red[300],
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
            separatorBuilder: (context, i) => const Divider(),
            itemCount: users.length));
  }
}
