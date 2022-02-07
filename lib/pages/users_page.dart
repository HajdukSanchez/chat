import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/user.dart';
import 'package:chat/widgets/user_list_tile.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final _users = [
    User(online: true, name: "Jozek", email: "jozekhs@gmail.com", uid: "1"),
    User(online: false, name: "Andres", email: "jozekhs@gmail.com", uid: "2"),
    User(online: true, name: "Fernando", email: "jozekhs@gmail.com", uid: "3"),
    User(online: false, name: "Juan", email: "jozekhs@gmail.com", uid: "5"),
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  ListView _usersListView() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) => UserListTile(user: _users[i]),
        separatorBuilder: (context, i) => const Divider(),
        itemCount: _users.length);
  }

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
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _onRefresh,
          header: WaterDropHeader(
              complete: Icon(Icons.check_circle, color: Colors.blue[400]),
              waterDropColor: Colors.blue),
          child: _usersListView(),
        ));
  }
}
