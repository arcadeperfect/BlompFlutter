import 'dart:io';

import 'package:flutter/material.dart';

class MyAppState with ChangeNotifier {
  InternetAddress? _serverAddress;
  int? _handShakePort;
  int? _uniquePort;

  // String? get serverAddress => _serverAddress;
  InternetAddress? get serverAddress => _serverAddress;

  int? get handShakePort => _handShakePort;
  int? get uniquePort => _uniquePort;

  void setServerAddress(InternetAddress address) {
    print("setServerAddress {address}");
    _serverAddress = address;
    notifyListeners();
  }

  void setHandShakePort(int port) {
    print("setHandShakePort {port}");
    _handShakePort = port;
    notifyListeners();
  }

  void setUniquePort(int port) {
    print("setUniquePort $port");
    _uniquePort = port;
    print('_uniquePort is $_uniquePort');
    notifyListeners();
  }
}