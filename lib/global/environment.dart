import 'dart:io';

class Environment {
  static String API_URL = Platform.isAndroid
      ? 'http://10.0.2.2:3000/api'
      : 'http://localhost:3000/api';

  static String SOCKET_URL =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
