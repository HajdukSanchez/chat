import 'package:chat/enums/socket.enum.dart';
import 'package:chat/global/environment.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket? get socket => _socket;
  Function get emit => _socket.emit;

  void connect() {
    _socket = IO.io(Environment.SOCKET_URL, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
    });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}