import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
    Navigator.pushNamed(context, '/scanFound');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}


// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class Scanner extends StatelessWidget {
//   const Scanner({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MobileScanner(
//         controller: MobileScannerController(
//           detectionSpeed: DetectionSpeed.normal,
//           facing: CameraFacing.back,
//           torchEnabled: false,
//         ),
//         onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           final Uint8List? image = capture.image;
//           for (final barcode in barcodes) {
//             debugPrint('Barcode found! ${barcode.rawValue}');
//           }
//           switchState(barcodes[0].rawValue.toString(), context);
//         },
//       ),
//     );  }

//   void switchState(String result, BuildContext context) {
//     print("scanned");
//     Navigator.pushNamed(context, '/scanFound');
//   }
// }
