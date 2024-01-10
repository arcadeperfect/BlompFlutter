import 'dart:typed_data';
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

  // void switchState(String result, BuildContext context) {
  //   Navigator.pushNamed(context, '/scanFound');
  // }
  void switchState(String result, BuildContext context) {
    // Extract the desired data from the result
    // For example, if result is a string with address and port separated by a comma
    final parts = result.split(',');
    final address = parts[0];
    final port = int.tryParse(parts[1]) ?? 0;

    // Update AppState
    final appState = Provider.of<AppState>(context, listen: false);
    appState.setServerAddress(address);
    appState.setHandShakePort(port);

    // Navigate to the next screen
    Navigator.pushNamed(context, '/scanFound');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}


