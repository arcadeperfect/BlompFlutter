import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String? _serverAddress;
  int? _handShakePort;
  int? _uniquePort;

  String? get serverAddress => _serverAddress;
  int? get uniquePort => _handShakePort;

  void setServerAddress(String address) {
    _serverAddress = address;
    notifyListeners();
  }

  void setHandShakePort(int port) {
    _handShakePort = port;
    notifyListeners();
  }

  void setUniquePort(int port) {
    _uniquePort = port;
    notifyListeners();
  }
}