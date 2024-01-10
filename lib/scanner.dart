import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:party/appState.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            debugPrint('Barcode found! ${barcodes[0].rawValue}');
            controller.stop();
            switchState(barcodes[0].rawValue.toString(), context);
          }
        },
      ),
    );
  }

  void switchState(String result, BuildContext context) {

    final parts = result.split(',');
    if(parts.length != 2) {
      throw Exception('parts.length != 2');
    }
    final address = parts[0];
    if(!isValidIPv4(address)) {
      throw Exception('address is not valid');
    }
    final port = int.tryParse(parts[1]) ?? null;

    if(port == null) {
      throw Exception('port is not valid');
    }

    // Update AppState
    final appState = Provider.of<MyAppState>(context, listen: false);
    appState.setServerAddress(InternetAddress(address));
    appState.setHandShakePort(port);

    // Navigate to the next screen
    Navigator.pushNamed(context, '/scanFound');
  }


  bool isValidIPv4(String ip) {
  final ipv4Regex = RegExp(
    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}'
    r'(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
  return ipv4Regex.hasMatch(ip);
}


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}


