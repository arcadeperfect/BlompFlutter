import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party/appState.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final MyAppState appState = Provider.of<MyAppState>(context, listen: false);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Scan QR'),
          onPressed: () {
            print("pressed");
            Navigator.pushNamed(context, '/scanner');

            // appState.setServerAddress(InternetAddress('10.100.4.110'));
            // appState.setHandShakePort(8000);
            // Navigator.pushNamed(context, '/scanFound');

          },
        ),
      ),
    );
  }
}