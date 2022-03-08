import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/widgets/user_list_tile.dart';
import 'package:chat/models/user.dart';
import 'package:chat/enums/socket.enum.dart';
import 'package:chat/enums/routes.enum.dart';
import 'package:chat/services/users_service.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersService = UsersService();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<User> users = [];

  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.user;
    FocusScope.of(context).unfocus(); // Unfocus the keyboard

    onLogOut() {
      socketService.disconnect();
      Navigator.pushReplacementNamed(context, routes.login.name);
      AuthService.deleteToken();
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            user != null ? user.name : "",
            style: const TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          // For example we can add an icon to close session
          leading: IconButton(
              onPressed: onLogOut,
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black54,
              )),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: socketService.serverStatus == ServerStatus.online
                  ? Icon(Icons.check_circle, color: Colors.blue[400])
                  : Icon(Icons.offline_bolt_rounded, color: Colors.red[400]),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: loadUsers,
          header: WaterDropHeader(
              complete: Icon(Icons.check_circle, color: Colors.blue[400]),
              waterDropColor: Colors.blue),
          child: _usersListView(),
        ));
  }

  void loadUsers() async {
    users = await usersService.getUsers();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  ListView _usersListView() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) => UserListTile(user: users[i]),
        separatorBuilder: (context, i) => const Divider(),
        itemCount: users.length);
  }
}
